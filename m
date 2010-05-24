From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 24 May 2010 10:08:52 +0530
Subject: Should we pass amba device peripheral id with device structure
	or not?
In-Reply-To: <20100521193802.GG11042@n2100.arm.linux.org.uk>
References: <4BECF57A.4050802@st.com>
	<20100521193802.GG11042@n2100.arm.linux.org.uk>
Message-ID: <4BFA02DC.6090906@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/22/2010 1:08 AM, Russell King - ARM Linux wrote:
> On Fri, May 14, 2010 at 12:32:18PM +0530, Viresh KUMAR wrote:
>> amba_device_register function reads and updates peripheral id from
>> hardware registers, whenever we register any amba device. If clock
>> to device is disabled, then amba_device_register will not be able
>> to read and update this value.
> 
> This is a potential problem - if the drivers are already initialized
> in the kernel, then the drivers will try to initialize as soon as
> amba_device_register() is called.  If the registers aren't accessible
> at amba_device_register() time, the driver initialization could fail.
> 
> I think it's better to understand what's going on here before making
> suggestions.
> 
> The clks in the primecell drivers are for the external side clocks
> only; these drivers all make the assumption that the AMBA bus clock
> is always enabled.  Does your SoC turn the AMBA bus clock to peripherals
> on and off?

There is only one bit per peripheral to enable/disable clock.
So with clocks disabled, we get 0x00000000 on read from device registers.
