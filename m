From: joel@jms.id.au (Joel Stanley)
Date: Fri, 6 May 2016 16:58:06 +0930
Subject: [PATCH v2 09/11] arm/dst: Add Aspeed ast2500 device tree
In-Reply-To: <loom.20160506T005831-472@post.gmane.org>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <1461225849-28074-10-git-send-email-joel@jms.id.au>
 <loom.20160506T005831-472@post.gmane.org>
Message-ID: <CACPK8Xe2jjTuMeE2kPacFcGjGFkKFSJHwxHMRgrd93G1T+FX7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 6, 2016 at 8:41 AM, Xo Wang <xow@google.com> wrote:
> Joel Stanley <joel <at> jms.id.au> writes:
>> +/ {
>> +     model = "AST2500 EVB";
>> +     compatible = "aspeed,ast2500";
>> +
>> +     chosen {
>> +             stdout-path = &uart5;
>> +             bootargs = "console=ttyS4,115200";
>> +     };
>> +
>> +     memory {
>> +             reg = < 0x80000000 0x10000000 >;
>
> The AST2500 EVB has an SK Hynix H5AN4G6NMFR 4Gb part, so this should be
> 0x20000000 for size.

Well caught. I've got a different part on my v1.1 board, but it is also 4Gbit.

>
>> +                     uart1: serial <at> 1e783000 {
>> +                             compatible = "ns16550a";
>> +                             reg = <0x1e783000 0x1000>;
>> +                             reg-shift = <2>;
>> +                             interrupts = <9>;
>> +                             clock-frequency = <1843200>;
>
> The AST2500 datasheet 39.3.1 states the input clock to their 16550 IP is
> 24 MHz. Their u-boot code also has #define CONFIG_SYS_NS16550_CLK
> 24000000. I suspect we hit a path in the serial/8250 driver that doesn't
> change the divisor from what u-boot set, which is why this has worked.

You're correct, we are relying on uboot. There's also a tricky 'div13'
register in the SCU that we are setting in our board file for these
numbers to work out.

In V3 I've added a clk driver to take are of these details.

>
> Thanks for the porting work!

Thanks for the review. Did you manage to get these patches booting on
your board?

Cheers,

Joel
