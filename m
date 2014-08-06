From: achandran@mvista.com (Arun Chandran)
Date: Wed, 6 Aug 2014 21:21:07 +0530
Subject: Kexec on arm64
In-Reply-To: <CAFdej02ZsLuxd84fb-n9Q2yuhzqRba5cmx6G8pHk3QeqzpTLaQ@mail.gmail.com>
References: <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke>
 <20140724093603.GC4079@leverpostej>
 <1406247468.4062.59.camel@smoke>
 <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
 <1406333901.4062.69.camel@smoke>
 <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
 <20140728153812.GA2576@leverpostej>
 <1406592548.28348.49.camel@smoke>
 <CAFdej00is0kC-1q5uMNJL5APL1WezdNBg0jASgwYamsg5NO_Tg@mail.gmail.com>
 <20140729133557.GQ2576@leverpostej>
 <1406668741.28348.75.camel@smoke>
 <CAFdej02sTBsjHz+FCqjKkY9pF5sPF6n6QUtEadHi0hK3MxRxGA@mail.gmail.com>
 <CAFdej01ZHkTVZuN_0RrGbFmoG4_NTnwm6KDAPM_sf=zHBHSRwg@mail.gmail.com>
 <1407172869.8971.54.camel@smoke>
 <CAFdej02ZsLuxd84fb-n9Q2yuhzqRba5cmx6G8pHk3QeqzpTLaQ@mail.gmail.com>
Message-ID: <CAFdej009ODfW3OfsmjwREVypcKgFeaXUTSD1u+k6pVFaakUhew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 6, 2014 at 7:24 PM, Arun Chandran <achandran@mvista.com> wrote:
> Hi,
>
> On Mon, Aug 4, 2014 at 10:51 PM, Geoff Levand <geoff@infradead.org> wrote:
>> Hi Arun,
>>
>> On Mon, 2014-08-04 at 15:46 +0530, Arun Chandran wrote:
>>> The latest kexec code is working fine in LE/BE mode in UP configuration.
>>>
>>> I had to change kexec-tools code a bit to make sure that "kexec -l"
>>> is not putting dtb at an area where kernel is building its initial page
>>> tables.
>>
>> OK, I'll add in code to handle this.
>>
>>> Now before trying SMP configuration I want to know whether the below "kexec -e"
>>> scenarios are valid(required)?
>>>
>>> 1st stage                                  |               2nd stage
>>> ---------------------------------------------------------------------------------------------
>>> LE UP                                      |               BE UP
>>> LE UP                                      |               BE SMP
>>> LE UP                                      |               LE SMP
>>> LE SMP                                   |               LE UP
>>> LE SMP                                   |               BE UP
>>> LE SMP                                   |               BE SMP
>>
> I am testing "kexec -e" with the script below(it will either
> reboot the board to BE or LE mode randomly).
>
> This test is done without L3 cache. With L3 I have more troubles.
> I think it is best to fix the code without L3 then move
> to testing with L3. That fix may solve the problem with L3
>
> ###############################
> :~$ cat /etc/init.d/S50reboot
> #!/bin/sh
>
> sleep 5
> i=$RANDOM
> j=$(( $i % 2))
>
> if [ $j -eq 0 ] ; then
>         mount /dev/mmcblk0p1 /mnt
>
>         count=`cat /mnt/cnt`
>         echo "KEXEC rebootng to BE count = $count"
>         echo $RANDOM > /mnt/"$count""_BE"
>
>         count=$(( $count + 1 ))
>         echo "$count">/mnt/cnt
>
>         kexec -l /mnt/vmlinux_BE.strip
> --command-line="console=ttyS0,115200 earlyprintk=uart8
> 250-32bit,0x1c020000 debug swiotlb=65536 log_buf_len=2M"
>         umount /mnt
>         kexec -e
> else
>         mount /dev/mmcblk0p1 /mnt
>
>         count=`cat /mnt/cnt`
>         echo "KEXEC rebooting to LE count = $count"
>         echo $RANDOM > /mnt/"$count""_LE"
>
>         count=$(( $count + 1 ))
>         echo "$count">/mnt/cnt
>
>         kexec -l /mnt/vmlinux_LE.strip
> --command-line="console=ttyS0,115200 earlyprintk=uart8
> 250-32bit,0x1c020000 debug swiotlb=65536 log_buf_len=2M"
>         umount /mnt
>         kexec -e
> fi
>
> exit $?
> #############################
>

Some more information:

I am able to run the same test (without L3) for 1.5 hours in case of
no endian switching.

For this testing I used the latest code @
https://git.linaro.org/people/geoff.levand/linux-kexec.git
unlike in the endian switching scenario there is no code change
made for this test.

It ran 370 times for LE-->LE reboots.
It ran 351 times for BE-->BE reboots.

I had to manually stop both tests as it was continuing
without any problem.

I will repeat the same test with L3 cache on

--Arun
