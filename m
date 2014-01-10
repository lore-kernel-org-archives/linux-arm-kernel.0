From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 10 Jan 2014 14:28:29 +0100
Subject: DT include files
In-Reply-To: <CAOesGMh3HBCYut2hfub3svrJT5JJzoWq8mU=VU0grZbg-JqqbA@mail.gmail.com>
References: <20131231054427.GA22383@S2101-09.ap.freescale.net>
 <20140102202108.GF19720@quad.lixom.net>
 <20140103023211.GA25079@S2101-09.ap.freescale.net>
 <CAOesGMheei8YgzfRp9pmQ0rT9zhJ2_hF56j5Y+jLSy5TadPZ-g@mail.gmail.com>
 <20140103030455.GB25079@S2101-09.ap.freescale.net>
 <CAOesGMihX-pLva-aBCHJ6TYfsN57MzRWiYFTnfKCXOKeja0uUg@mail.gmail.com>
 <20140104011056.GA3282@S2101-09.ap.freescale.net>
 <20140110024124.GA6844@S2101-09.ap.freescale.net>
 <CAOesGMh3HBCYut2hfub3svrJT5JJzoWq8mU=VU0grZbg-JqqbA@mail.gmail.com>
Message-ID: <52CFF57D.8060808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10.01.2014 03:41, Olof Johansson wrote:
> On Thu, Jan 9, 2014 at 6:41 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> On Sat, Jan 04, 2014 at 09:10:58AM +0800, Shawn Guo wrote:
>>> On Fri, Jan 03, 2014 at 11:29:35AM -0800, Olof Johansson wrote:
>>>> On Thu, Jan 2, 2014 at 7:04 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
>>>>> On Thu, Jan 02, 2014 at 06:41:30PM -0800, Olof Johansson wrote:
>>>>>> Ok, then it's probably just the location of the header files that
>>>>>> should be adjusted. Other subsystems have placed them under
>>>>>> include/dt-bindings/<subsystem>, so that's likely a better place for
>>>>>> these as well, don't you think?
>>>>>
>>>>> I had a little discussion with DT people when the headers were firstly
>>>>> created.  These pinctrl headers are a little different from the headers
>>>>> in include/dt-bindings/<subsystem>.  The latter are used by both kernel
>>>>> and device tree sources, while the pinctrl headers are used by device
>>>>> tree sources only, so I chose to put them just in the same folder as
>>>>> dts files.  And DT people are fine with my take.
>>>>
>>>> Since you don't provide references to this I had to go searching for
>>>> it. All I find is some discussion from 8 months ago, and quite a bit
>>>> of that seems to have been about changing bindings, and some about the
>>>> preprocessor behavior. Also, the patches seem to have been too big to
>>>> make it out on the lists.
>>>>
>>>> I'd like a fresh look from DT people on this just to make sure no
>>>> opinions have changed -- lots of things have changed in the last 8
>>>> months w.r.t. DT.
>>>
>>> Indeed, it's been quite a long time.  Let me restate my point.  The
>>> include/dt-bindings is introduced as a folder to hold headers that are
>>> referenced by both kernel and DTS.  That's why we create the folder in
>>> the kernel include folder and have arch/arm/boot/dts/include/dt-bindings
>>> being a symbol link to it.  All the headers in there need to be
>>> duplicated between kernel and DTS tree, when we move DTS files into
>>> a separated repository.  Putting DTS local headers into the folder is
>>> absolutely unnecessary, and will only confuse people and bother
>>> ourselves when moving DTS files out of kernel tree.
>>
>> Just a gentle ping to ensure we do not get the pull request lost.  Or do
>> you have any further comment?
>
> Still waiting on DT maintainers to chime in.

I'm not officially a DT maintainer, but let me share my thoughts on this.

So what options we have for this:

  1) include/dt-bindings - this directory is designed to contain headers
     that define the ABI between firmware and kernel code, in other
     words - DT bindings.

  2) arch/*/boot/dts - we already have files that can be included by
     other files in this directory, i.e. *.dtsi. Some are used to
     implement hierarchies of devices (e.g. s3c64xx.dtsi), but some are
     purely used as headers (s3c64xx-pinctrl.dtsi).

  3) include/dts? - I'm not sure if this have any benefits, but I'm
     listing it since it's one of the ideas that came to my mind.

Now 2) seems to be already used and doesn't seem to generate any 
problems, so I'm all for it. Still, there is one more issue. For files 
to be included merely by DTS files and so limited by DTS+CPP syntax, I 
don't think it's too good idea to call them *.h. Let's stay with *.dtsi, 
since that's the file extension supposed to be used for files that can 
be included from device tree sources.

Best regards,
Tomasz
