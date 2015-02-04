From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 05 Feb 2015 01:43:01 +0300
Subject: [PATCH] ARM: shmobile: alt dts: Drop console= bootargs parameter
In-Reply-To: <20150203004146.GB17629@verge.net.au>
References: <1415075018-27529-1-git-send-email-horms+renesas@verge.net.au>
 <54CBFC63.4070808@cogentembedded.com> <20150131041731.GA7605@verge.net.au>
 <54CFF5F1.2040007@cogentembedded.com> <20150203004146.GB17629@verge.net.au>
Message-ID: <54D2A075.3020904@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/03/2015 03:41 AM, Simon Horman wrote:

>>>>> Alt is booted from DT, so chosen/stdout-path is
>>>>> always used, and we can drop the "console=" parameter from chosen/bootargs.

>>>>> This change has a side-effect of changing the console speed from 38400
>>>>> to 115200. This is intentional as 115200 is consistently used on
>>>>> all other shmobile boards.

>>>>     I'd say it's not very practical to change the console's baud rate from
>>>> U-Boot's default

>>> It is consistent with the handling of all other boards with
>>> renesas SoCs that are present in mainline.

>>     Well, not quite: Henninger/Porter is still using 38400.

>  From my point of view that is an oversight which I would have
> resolved had I ever obtained access to the hardware.

    I'll look into that when I have time.

>>>> (AFAIR changing baud rate in U-Boot didn't work)...

>>     That was a recollection from the other board though, I haven't yet tried
>> to do it on the SILK board (and I'm unable to currently as the power supply
>> seems dead).

>>> Perhaps that relates to the version of built of uboot.
>>> On the board I have access to I see:

>>> ver=U-Boot 2013.01.01-g5df9446 (Oct 01 2014 - 14:59:23)

>> U-Boot 2013.01.01 (Oct 17 2014 - 20:59:18)

> It looks like my version has some extra patches (the g5df9446 bit).
> But I could be reading things wrong.

>>> And the following setting altered the baud rate of u-boot (IIRC).

>>> baudrate=115200

>>     I was going to try that but the board just didn't power up.

    I have switched to another board now (with newer U-Boot flashed),
and I was able to change the baud rate in U-Boot. However, SPL and U-Boot
still start at 38400 and now I'm having garbage instead of the version and 
hardware info. :-(

>>>>> Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>> Cc: devicetree at vger.kernel.org
>>>>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>>>> ---
>>>>>   arch/arm/boot/dts/r8a7794-alt.dts | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)

>>>>> diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
>>>>> index 8aec512..f2cf757 100644
>>>>> --- a/arch/arm/boot/dts/r8a7794-alt.dts
>>>>> +++ b/arch/arm/boot/dts/r8a7794-alt.dts
>>>>> @@ -20,7 +20,7 @@
>>>>>   	};
>>>>>
>>>>>   	chosen {
>>>>> -		bootargs = "console=ttySC0,38400 ignore_loglevel rw root=/dev/nfs ip=dhcp";
>>>>> +		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";

>>>>     Hm, does this even work as intended? I've tried to boot another R8A7794
>>>> based board and I couldn't get any output with alike command line. Booting
>>>> with 'earlyprintk=serial' has shown that tty0 was enabled as a console which
>>>> is not what we wanted.

    The kernel console started working automagically for me at 115200 on the 
new board.

>>> If you are backporting this change then I believe it has some dependencies
>>> that I can follow up on if it is useful to you.

>>     Contrariwise, I'm forward-porting.

>>> If you are using mainline (e.g. next or renesas-next) then yes,
>>> it works. I have tested it numerous times since the patch was merged.

>>     I'm traditionally using the 'renesas-devel-*' tags.

> If you are using 'renesas-devel-*' tags (and forward porting) then
> you should be in good shape. But if you would like me to verify a particular
> tag I'm happy to do so. It is not unheard of for different instances of
> the same board behave in different ways.

    Thank you, looks like there's no need now.

WBR, Sergei
