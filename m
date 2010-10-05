From: san.mlists@gmail.com (Santhosh N)
Date: Tue, 5 Oct 2010 17:01:33 +0530
Subject: PXA270 linux-2.6.35.7 boot hang
In-Reply-To: <201010030542.22204.marek.vasut@gmail.com>
References: <AANLkTim4HqQkT0uZTpsGCsFqObVA+v+Q7wHekGp5V+f3@mail.gmail.com>
	<AANLkTi=JEUbxmTZ6PHbz_Gi7KvNf+KJat7R1ot5LQ1SH@mail.gmail.com>
	<20101001173706.00006c12@unknown>
	<201010030542.22204.marek.vasut@gmail.com>
Message-ID: <AANLkTi=cfcN66GMO9Y3gRSeis7F0R4Sybeo_F-NTFVLj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am now able to boot the linux kernel 2.6.35.7 on our PXA board.

DEBUG_LL and early_printk were very useful in solving the problem. Had
to make a change in arch/arm/mach-pxa/include/mach/debug-macro.S for
the early_printk to work. In that, the FFUART address is hard-coded.
Also, during the boot process it was getting hung at calibrate_delay
function in init/main.c. Had enable to the OS timer clock to get
across that. After that, the kernel boot messages started appearing.
In 2.6.26, the boot messages were getting printed even before the call
to calibrate_delay function. All the 3 UARTS in PXA270 support upto
921k baud. I am using the Uboot(v2009.08) from www.denx.de.

Thanks everyone for all your valuable inputs.

But, the above was just a small step in solving a bigger problem I am
facing. Few weeks back I had mailed an issue regarding audio hang
problem. I was suggested by Marek to move to the latest kernel. I also
tried comparing the audio source code between 2.6.26 and 2.6.35.7. I
did not find much significant difference in the hardware interface
part except for the source code re-organization. But, there are a lot
of changes in the top layer audio source code. I tried digging much
deeper in understanding the DMA operation. I found a situation where
the DMA stops giving interrupts and is reflected in the DCSR register.
I am still not able to know, what is triggering that. I will try the
latest kernel and reply back on that thread.

Warm regards,
Santhosh N

On Sun, Oct 3, 2010 at 9:12 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne P? 1. ??jna 2010 17:37:06 Dylan Cristiani napsal(a):
>> On Fri, 1 Oct 2010 21:53:14 +0800
>>
>> Eric Miao <eric.y.miao@gmail.com> wrote:
>> > On Fri, Oct 1, 2010 at 6:33 PM, Santhosh N <san.mlists@gmail.com>
>> >
>> > wrote:
>> > > Hi,
>> > >
>> > > I am porting the latest linux kernel 2.6.35.7 on our PXA270 board.
>> > > The kernel starts booting and stops at:
>> > > Uncompressing Linux... done, booting the kernel.
>> > >
>> > > I can run the linux kernel 2.6.26 on the same board without any
>> > > issues. I am passing the boot args as:
>> > > bootargs=console=ttyS2,460800 rw root=1f02
>> > >
>> > > The STUART is used as the debug serial port. I had to change the
>> > > uart_base to STUART in arch/arm/mach-pxa/include/mach/uncompress.h
>> > > to get ?"Uncompressing Linux... done, booting the kernel.".
>> > >
>> > > I have set also set CONFIG_SERIAL_PXA_CONSOLE=y.
>> > >
>> > > Can anyone tell if I am missing something?
>> >
>> > There could be many reasons. But you may want to turn on DEBUG_LL
>> > and earlyprintk for some early diagnostic messages. You got
>> > "Uncompress ..." messages so I assume the UART is setup correctly to
>> > this weird 460800 baudrate (though I doubt STUART on PXA27x is able
>> > to do that)
>>
>> i agree with Eric but i remember that the maximum baud rate is 921,600
>> bps for all S-FF-BTUART pxa's uarts; maybe you can try also to migrate
>> from working kernel 2.6.26 to 2.6.27.... and so on, to see when it
>> first hangs, then seeing what was changed, with relation with
>> your specific cpu and/or platform, could be the trick.
>
> You can send me a sample board, one more into collection never hurts :-D
>
> btw. as Eric pointed out already (and according to brief look at Table 212 ...
> or am I missing something), the baudrate setting looks suspicious. What setting
> do you use in U-Boot (I believe you use U-Boot by seeing "bootargs=").
>
> Also, what serial port do you use in U-Boot ? (grep UART
> include/configs/yourboard.h ; grep BAUD include/configs/yourboard.h)
>
> Also, what U-Boot do you use (and from where) ?
>
> Cheers
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
