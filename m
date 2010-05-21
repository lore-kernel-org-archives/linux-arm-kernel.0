From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 May 2010 20:38:02 +0100
Subject: Should we pass amba device peripheral id with device structure
	or not?
In-Reply-To: <4BECF57A.4050802@st.com>
References: <4BECF57A.4050802@st.com>
Message-ID: <20100521193802.GG11042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 12:32:18PM +0530, Viresh KUMAR wrote:
> amba_device_register function reads and updates peripheral id from
> hardware registers, whenever we register any amba device. If clock
> to device is disabled, then amba_device_register will not be able
> to read and update this value.

This is a potential problem - if the drivers are already initialized
in the kernel, then the drivers will try to initialize as soon as
amba_device_register() is called.  If the registers aren't accessible
at amba_device_register() time, the driver initialization could fail.

I think it's better to understand what's going on here before making
suggestions.

The clks in the primecell drivers are for the external side clocks
only; these drivers all make the assumption that the AMBA bus clock
is always enabled.  Does your SoC turn the AMBA bus clock to peripherals
on and off?

If so, we need to expand drivers/amba/bus.c to deal with this.
