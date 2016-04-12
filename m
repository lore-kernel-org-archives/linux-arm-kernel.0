From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 13 Apr 2016 01:03:14 +0200
Subject: [PATCH 2/7] ARM: dts: skeleton: add unit name to memory node
In-Reply-To: <CAL_JsqK7Fwk0CTW420=NFja5Asq22ckanWZGWp0G7Wo4rS9gkQ@mail.gmail.com>
References: <1459290646-3592-1-git-send-email-manabian@gmail.com>
 <1459290646-3592-3-git-send-email-manabian@gmail.com>
 <20160330110611.GB25354@leverpostej> <56FBCF70.80006@mentor.com>
 <20160330134155.GC25354@leverpostej>
 <CAGhQ9VykiwMWaw3xcJdg2CahNFt+sp7tFC5O8VwA=-_=UoJ8kA@mail.gmail.com>
 <20160330170645.GA13690@leverpostej>
 <CAGhQ9Vykn=G+cmVuBCAA_ATTz4XNEPeUWYbZRb5NsrVBOjaS-A@mail.gmail.com>
 <20160331103800.GC26532@leverpostej>
 <CAGhQ9Vy8TKPxPdYF-wXbCo_LZkBsSsficEG8wCn1bCbS9JN+vg@mail.gmail.com>
 <CAGhQ9VyQYeKrpPD-YhWjysvHmYaKssCO7xsU9MyRvFivEym=Hw@mail.gmail.com>
 <CAL_JsqK7Fwk0CTW420=NFja5Asq22ckanWZGWp0G7Wo4rS9gkQ@mail.gmail.com>
Message-ID: <CAGhQ9VzaUwOhEoLE+L3DkTtFscsu65PtRm0ijhQzA51=ud8nPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 April 2016 at 00:45, Rob Herring <robh+dt@kernel.org> wrote:
> On Thu, Mar 31, 2016 at 11:34 AM, Joachim  Eastwood <manabian@gmail.com> wrote:
>> On 31 March 2016 at 17:21, Joachim  Eastwood <manabian@gmail.com> wrote:
>>> On 31 March 2016 at 12:38, Mark Rutland <mark.rutland@arm.com> wrote:
>>>> On Wed, Mar 30, 2016 at 10:45:06PM +0200, Joachim Eastwood wrote:
>>>>> On 30 March 2016 at 19:06, Mark Rutland <mark.rutland@arm.com> wrote:
>>>>> > On Wed, Mar 30, 2016 at 06:15:35PM +0200, Joachim Eastwood wrote:
>>>>> >> I used the following script to check for the memory node in all built dtb's.
>>>>> >>   make ARCH=arm CONFIG_OF_ALL_DTBS=y dtbs
>>>>> >>   for i in $(ls arch/arm/boot/dts/*.dtb); do
>>>>> >>          m=$(scripts/dtc/dtc -I dtb -O dts $i | grep -m1 'memory.*{')
>>>>> >>          if [ -z "$m" ]; then
>>>>> >>                  echo "Missing memory node in $i"
>>>>> >>           fi
>>>>> >>   done
>>>>> >>
>>>>> >> So it should be pretty safe to just remove the memory node entry in
>>>>> >> the skeleton files. Unless I have missed something with the script
>>>>> >> above.
>>>>> >
>>>>> > The above might match reserved-memory nodes; it might be better to check
>>>>> > for 'device_type\s*=\s*"memory"'.
>>>>>
>>>>> I did check the output of the grep and it looks good. But there are
>>>>> indeed DTs that are missing the 'device_type = "memory"' parameter.
>>>>> Actually; _a lot_ or 438 of 741 to be exact. ugh...
>>>>>
>>>>> I guess all those should be fixed up before we can remove the memory
>>>>> node from skeleton. :/
>>>>
>>>> Ouch, yes. :(
>>>>
>>>> That said, the cahnges don't need to be an atomic operation. We could
>>>> start adding device_type = "memory" to dts immediately (in as whatever
>>>> size batches maintainers are happy with), as a duplicate device_type
>>>> shouldn't be problematic.
>>>
>>> Yes, that is true.
>>>
>>>
>>>> When we hit critical mass, we could then remove the skeleton memory
>>>> nodes, fixing up any remaining fallout.
>>>>
>>>> As for the mechanical changes, it sounds like we need coccinelle for DT.
>>>>
>>>> That, or a laptop, a long flight, and a gin and tonic.
>>>
>>> :-)
>>>
>>> I'll see if I can cook up something with awk.
>>
>> Something like this should do it:
>> #!/usr/bin/gawk -f
>> # find arch/arm/boot/dts/ -type f -name *.dts* | xargs
>> ./mem_node_add_dev_type.awk -i inplace
>> BEGIN { go = 0 }
>> /[^-]memory ?{/ { go = 1; idx = 0; device_type = 0 }
>>
>> go == 1 {
>>         buf[idx++] = $0
>>         if ($0 ~ /device_type/)
>>                 device_type = 1
>>
>>         if ($0 ~ /};/) {
>>                 print buf[0]
>>
>>                 if (!device_type) {
>>                         buf[0] = buf[1]
>>                         gsub(/[^\t]*/, "", buf[0])
>>                         buf[0] = buf[0] "device_type = \"memory\";"
>>                 } else {
>>                         delete buf[0]
>>                 }
>>
>>                 for (i in buf)
>>                         print buf[i]
>>                 delete buf
>>
>>                 go = 0
>>                 device_type = 0
>>         }
>>         next
>> }
>>
>> { print }
>>
>> Gives me: 249 files changed, 249 insertions(+), 1 deletion(-) on v4.6-rc1.
>>
>> Running the my check script after this reveals that 83 DTs lack the
>> device_type parameter, but these seem to also lack the memory node as
>> well. Wonder why my script didn't pick up the missing memory node in
>> those... I also doubt that the memory node is set by the boot loader
>> in some of these boards.
>
> I don't think this script is right. It will not work if the memory
> node is spread across dtsi files. You would need to compiler
> everything to dtb and then back to a flat dts file before running thru
> this script.

The script will simply add 'device_type = memory' to all dts and dtsi
files that are missing this property.
What do you by spread across dtsi files? Got an example DT that I
could take a look at?


> I don't see the rest of the series in -next. Is that going to happen soon?

Pull request was sent to arm-soc some time ago, but it seems they
haven't pulled in anything for 4.7 yet.
Link: http://permalink.gmane.org/gmane.linux.ports.arm.kernel/490303
(All memory node "fixes" was removed from this pull request)


regards,
Joachim Eastwood
