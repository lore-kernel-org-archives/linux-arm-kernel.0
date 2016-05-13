From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 13 May 2016 09:17:02 +0800
Subject: [PATCH 1/2] arm64: dts: NS2: Add all of the UARTs
In-Reply-To: <befabac6-aae2-fb3b-2faa-5463b7287b2a@broadcom.com>
References: <1463007369-13071-1-git-send-email-jonmason@broadcom.com>
 <57341FCE.6050403@huawei.com>
 <CAC3K-4qbkt3DCgd6qurNo3V+++x70bbFC--aunR0DbCTBvBNZg@mail.gmail.com>
 <befabac6-aae2-fb3b-2faa-5463b7287b2a@broadcom.com>
Message-ID: <57352B0E.5070803@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/5/13 0:52, Ray Jui wrote:
> Hi Kefeng,
> 
> On 5/12/2016 7:46 AM, Jon Mason wrote:
>>
>>
>> On Thu, May 12, 2016 at 2:16 AM, Kefeng Wang <wangkefeng.wang@huawei.com
>> <mailto:wangkefeng.wang@huawei.com>> wrote:
>>
>>
>>
>>     On 2016/5/12 6:56, Jon Mason wrote:
>>     > Add all of the UARTs present on NS2 and enable them in the SVK device
>>     > tree file.  Also, do some magic to make sure that uart3 is discovered as
>>     > ttyS0 (as that is the console UART).
>>     >
>>     > Signed-off-by: Jon Mason <jonmason at broadcom.com <mailto:jonmason@broadcom.com>>
>>     > ---
>>     >  arch/arm64/boot/dts/broadcom/ns2-svk.dts | 16 ++++++++++++++++
>>     >  arch/arm64/boot/dts/broadcom/ns2.dtsi    | 30 ++++++++++++++++++++++++++++++
>>     >  2 files changed, 46 insertions(+)
>>     >
>>     > diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
>>     > index 7cd3640..b062a44 100644
>>     > --- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
>>     > +++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
>>     > @@ -40,10 +40,14 @@
>>     >
>>     >       aliases {
>>     >               serial0 = &uart3;
>>     > +             serial1 = &uart0;
>>     > +             serial2 = &uart1;
>>     > +             serial3 = &uart2;
>>     >       };
>>     >
>>     >       chosen {
>>     >               stdout-path = "serial0:115200n8";
>>     > +             bootargs = "earlycon=uart8250,mmio32,0x66130000";
>>
>>     Hi Jon,
>>
>>     I submit a patch[1], with it, we can use earlycon without option to
>>     enable early console
>>     for "snps,dw-apb-uart", could you help me to test it, thanks.
>>
>>
>> Adding your change and removing the line above does not cause earlycon
>> to work for me.  Is there any additional changes necessary for this to work?
>>
>> Thanks,
>> Jon
>>
> 
> "OF_EARLYCON_DECLARE" doesn't seem to have a way to deal with DT properties? In the case of UART for NS2, it needs mmio32, configured with DT property "reg-io-width" set to 4. I don't think "OF_EARLYCON_DECLARE" is parsing that, which is likely the reason why it doesn't work for devices that required mmio32.
> 
It should work, I test this in Hisi D02 board, it uses same uart and same configuration.

early_init_dt_scan_chosen_serial()
 for (match = __earlycon_table; match < __earlycon_table_end; match++)
 	......
	of_setup_earlycon()
		val = of_get_flat_dt_prop(node, "reg-io-width", NULL);  // will obtain the reg-io-width and set iotype=mmio32
		err = match->setup(&early_console_dev, options);  // call early_serial8250_setup

Could you check it again, thanks,

Kefeng


> Thanks,
> 
> Ray
> 
> .
> 
