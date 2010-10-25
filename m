From: dennis.borgmann@googlemail.com (Dennis Borgmann)
Date: Mon, 25 Oct 2010 12:58:14 +0200
Subject: at91sam9g20 hangs at ohci-hcd
In-Reply-To: <4CBDC1D8.6060706@atmel.com>
References: <4CBDAA96.5060107@googlemail.com> <4CBDC1D8.6060706@atmel.com>
Message-ID: <4CC562C6.5070107@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

the problem has been solved by setting buildroot and the kernel to run
on at91sam9260 instead of at91sam9g20. In addition, I had to make some
adjustments at the clock.c sorcecode in the kernel, which needs to have
some different timings. I cannot answer, why it is this way, but it
works for me.

Kind regards and thanks for your thoughts,
Dennis

Nicolas Ferre schrieb:
> Hi,
>
> I answer as private message as I am not coming with a real answer... Just a hint that can help you go forward.
>
> Le 19/10/2010 16:26, Dennis Borgmann :
>   
>> Hello linux-arm list!
>>
>> I am using an at91sam9g20-CPU on an "eddy-Board Version 2.5" from a
>> company called "Systembase" - see http://www.embeddedmodule.com
>>
>> I am booting my system via u-boot http://www.denx.de/wiki/U-Boot
>>
>> The problem that I see is, that the kernel won't boot up to a login
>> prompt, it simply hangs at the point, where it loads the USB driver
>> 'ohci-hcd'. The last output I get from the kernel booting messages are
>> appended below at the end of this mail.
>>
>> After searching the internet for two days now, I have given up the idea
>> to solve the problem on my own. The problem seems to be known to the
>> linux community, as I can find a link on this:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=11041
>>
>> People are talking about an endless loop involving modprobe at a certain
>> point and the solution for them is to revert a previous commit to their
>> code repository. This has been going on in 2008. Now, we have 2010 and I
>> would suggest this problem being solved. But still I cannot get the
>> board running.
>>
>> If I switch to an older release of the board - version 2.1, which
>> contains an at91sam9260 - everything works fine. The problem appears
>> with at91sam9g20.
>>     
>
> Strange. I did not test 9g20ek usb host recently but I cannot tell that I have a known issue...
>
>   
>> I am building my system with buildroot - http://buildroot.uclibc.org/ -
>> , tried already several kernels (2.6.25.20, 2.6.27.54, 2.6.33.7 and
>> 2.6.34.3) but none of them worked. I also tried giving buildroot a
>> kernel path from this webpage:
>>
>> http://maxim.org.za/at91_26.html
>>
>> For a first test, I chose version 2.6.33, which did not solve my problem
>> either.
>>
>> The code seems to hang in ohci-at91.c (for example located here:
>> linux-2.6.33.7/drivers/usb/host/ ) in function 'static void
>> at91_start_hc(struct platform_device *pdev)' . It can get up to line 69
>> ( 'writel(0, &regs->control);' ), but this call does not return. I found
>> this out by giving the code several printk's.
>>
>> There is no difference, if I compile the driver as module or directly
>> into the kernel. Either it hangs on boot-time or it hangs, when I do
>> 'modprobe ohci-hcd'.
>>
>> I don't know any more things to do. Could you give me hint, where to
>> search for my problem? It would be nice to be able to use kernel 2.6.34
>> due to wireless demands.
>>     
>
> I would advice you to test (even if you would prefer a newer kernel) 
> with 2.6.30 + at91 patches + "experimental" patches as described on
> http://www.linux4sam.org
> http://www.at91.com/linux4sam/bin/view/Linux4SAM/LinuxKernel#AT91_Linux_kernel_sources_summar
>
> Hope this helps,
>
> Best regards,
>   
