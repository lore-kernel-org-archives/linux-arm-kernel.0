From: michael.williamson@criticallink.com (Michael Williamson)
Date: Mon, 03 Jan 2011 08:28:37 -0500
Subject: [PATCH 1/2] davinci: Support disabling modem status interrupts
	on SOC	UARTS
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024816D2D7@dbde02.ent.ti.com>
References: <1293844317-11757-1-git-send-email-michael.williamson@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024816D2D7@dbde02.ent.ti.com>
Message-ID: <4D21CF05.7010704@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/3/2011 1:21 AM, Nori, Sekhar wrote:

> Hi Michael,
> 
> On Sat, Jan 01, 2011 at 06:41:56, Michael Williamson wrote:
>> On the da850/omap-l138/am18x family of SoCs, up to three on chip UARTS may be
>> configured.  These peripherals support the standard Tx/Rx signals as well as
>> CTS/RTS hardware flow control signals.  The pins on these SOC's associated with
>> these signals are multiplexed; e.g., the pin providing UART0_TXD capability
>> also provides SPI0 chip select line 5 output capability.  The configuration of
>> the pin multiplexing occurs during platform initialization (or by earlier
>> bootloader operations).
>>
>> There is a problem with the multiplexing implementation on these SOCs.  Only
>> the output and output enable portions of the I/O section of the pin are
>> multiplexed.  All peripheral input functions remain connected to a given pin
>> regardless of configuration.
>>
>> In many configurations of these parts, providing a UART with Tx/Rx capability
>> is needed, but the HW flow control capability is not.  Furthermore, the pins
>> associated with the CTS inputs on these UARTS are often configured to support
>> a different peripheral, and they may be active/toggling during runtime.  This
>> can result in false modem status (CTS) interrupts being asserted to the 8250
>> driver controlling the associated Tx/Rx pins, and can impact system
>> performance.  This is especially true if the CTS pin is shared with something
>> like a clock line as is the case with UART1 CTS and the McASP AHCLKX.
>>
>> The 8250 serial driver platform data does not provide a direct mechanism to
>> tell the driver to disable modem status (i.e., CTS) interrupts for a given
>> port.  As a work-around, allow davinci platforms to override set_termios for
>> configured UARTS that do not provide a true CTS input and ensure any request
>> does not enable HW flow control.
>>
>> This patch was tested using a MityDSP-L138 SOM having UART1 enabled with the
>> associated CTS pin connected to a clock (configured for the AHCLKX function).
>>
>> Background / problem reports related to this issue are captured in the links
>> below:
>> http://e2e.ti.com/support/dsp/omap_applications_processors/f/42/t/36701.aspx
>> http://www.mail-archive.com/davinci-linux-open-source at linux.davincidsp.com/msg19524.html
>>
>> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
>> Tested-by: Michael Williamson <michael.williamson@criticallink.com>
>> ---
>> This patch is against davinci-linux.
>>
>> I'm open to suggestions for reducing the patch description.
>>
>> I'm open to alternatives to the solution below, outside of disabling the
>> UARTs in question as is done on the DA850 evm and the hawkboard (both
>> of which might be able to use this patch?).
> 
> Can you please CC linux-serial on this patch? Folks on that list
> will have ideas on how best to work around this issue.
> 
> I think setting the UART_BUG_NOMSR in up->bugs for these ports
> (as you previously implemented on your tree) is a better patch
> since it utilizes an existing established mechanism. 
> 
> I understand there is no existing way to pass the bugs through
> platform data, but may be that needs to be created (or may be
> have a new port type for "DaVinci UART with no flow control" and
> then setup up->bugs after checking for this port type).
> 


I will post to linux-serial and see what their take is on this issue.

Thanks for the comments.

-Mike
