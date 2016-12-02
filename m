From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 2 Dec 2016 14:46:52 +0100
Subject: XHCI controller does not detect USB key insertion
In-Reply-To: <58414BC5.109@free.fr>
References: <584134D9.5000404@free.fr> <87inr2vh2l.fsf@linux.intel.com>
 <58414BC5.109@free.fr>
Message-ID: <96d38b62-135e-9787-e8b5-1ac3e820c23b@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2016 11:24 AM, Mason wrote:
> On 02/12/2016 10:03, Felipe Balbi wrote:
> 
>> Mason wrote:
>>
>>> I'm trying out a SoC with a brand new USB controller, which is (supposedly)
>>> a standard XHCI controller. In theory, I would just need to build the right
>>> driver, and everything would auto-magically work, right?
>>
>> perhaps, but there might be needed initialization of other resources
>> like PHYs and stuff like that.
> 
> Let me dive into additional details...
> 
> First of all, there is a register aptly called "USB3_RESET" which
> is used to release several USB3-related blocks from reset.
> Of course, that's the first register I tweaked :-)
> 
> There are *3* address ranges with USB3-related registers.
> 
> 1) one called host_usb30_xhcl (I believe "xhcl" is a typo for "xhci")
> This is the address I passed to the Linux driver. The first register
> is CAPLENGTH_VERSION. I assume these are the standard XHCI registers.
> (Last register is XHCL_EXTENDED_CAP3_USB3 at offset 0xc008)
> 
> 2) one called host_usb30_port
> This contains "Device and Port Specific Registers".
> Is it standard?
> How is Linux supposed to know where to find it?
> Contains registers such as
> Device Transaction Status
> Device UTMI command and status for USB2
> Set ISOC Delay
> USB3 Function Notification
> Rx DMA BD Start Address for Control Endpoint
> EP Burst Size
> Tx DMA BD Start Address Control Endpoint
> EP $N IN/OUT
> Device Notification Register
> EP_Isochronous Timestamp
> 
> Are registers named LTSSM_TIMER_REGISTER{1,2,3} standard?
> they have fields such as reg_12_ms_timeout (and other numbers like 2, 6, 100, 300)
> 
> 3) one called host_usb30
> This contains lower-level stuff
> 0x2e800	CONFIG
> 0x2e804	CONTROL
> 0x2e808	TEST
> 0x2e80c	STATUS
> 0x2e810	CLK_RST_0
> 0x2e814	CLK_RST_1
> 0x2e818	PARAM_0
> 0x2e81c	PARAM_1
> 0x2e820	PARAM_2
> 0x2e880	SNPS_CR_ADD
> 0x2e884	SNPS_CR_DATA
> 0x2e8c0	RESET_CTRL
> 
> I haven't touched any of these so far.
> 
> 
>>> # lsusb -v
>>> Bus 001 Device 001: ID 1d6b:0002
>>> Bus 002 Device 001: ID 1d6b:0003
> 
> Isn't lsusb verbose supposed to print much more than that?
> 
> 
>>> I'd like to hear suggestions about what I can tweak to fix the problem.
>>
>> go to your documentation and see if you have initialized
>> everything. Which SoC is this?
> 
> (Sad face) All the documentation I have is in front of me, and nothing
> is ringing a bell. This is a Sigma Designs SoC, with a Pravega XHCI
> controller + Synopsys PHY.
> 
> The documentation I have:
> 
> Pravega_Dual_Mode_Datasheet_v10c.pdf (documents IP signals)
> Pravega_Dual_Mode_Controller_Programmers_Reference_manual_v1.pdf (documents IP registers)
> PHY databook (very low-level stuff)
> SoC register mapping (for how the SoC maps the IP signals to registers)

You should have all the necessary bits to enable and configure the Embedded Synopsys PHY !

You should have some register mapping of the PHY signals, or at least a way to write those registers.

You should have a reset, clock gate and eventually a power regulator to enable in order to have the PHY running.

> 
> So far, I'm stumped :-(
> 
> Regards.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
