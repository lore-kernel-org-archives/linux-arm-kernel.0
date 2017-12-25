From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 25 Dec 2017 15:17:50 -0800
Subject: [patch v15 0/4] JTAG driver introduction
In-Reply-To: <1514202808-29747-1-git-send-email-oleksandrs@mellanox.com>
References: <1514202808-29747-1-git-send-email-oleksandrs@mellanox.com>
Message-ID: <4425f51e-d3b3-3555-7afd-5dd1b1e698fa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/25/17 ? 03:53, Oleksandr Shamray a ?crit?:
> When a need raise up to use JTAG interface for system's devices
> programming or CPU debugging, usually the user layer
> application implements jtag protocol by bit-bang or using a 
> proprietary connection to vendor hardware.
> This method can be slow and not generic.
>  
> We propose to implement general JTAG interface and infrastructure
> to communicate with user layer application. In such way, we can
> have the standard JTAG interface core part and separation from
> specific HW implementation.

Well, the framework in its current shape is still extremely simplistic,
therefore leaving a lot of room (read: bugs, inconsistencies) within the
hands of the driver, so while the user-space interface is standard
through the proposed character device, the user experience, likely might
not.

> This allow new capability to debug the CPU or program system's 
> device via BMC without additional devices nor cost. 

If that is the case, should not we leverage the kernel's device driver
model and expect the JTAG framework to create specific devices for the
different pieces of HW discovered on the scan chain? That would also
presumably allow the core JTAG framework to retain the necessary state
changes in order to address one particular device within the scan chain.

> 
> This patch purpose is to add JTAG master core infrastructure by 
> defining new JTAG class and provide generic JTAG interface
> to allow hardware specific drivers to connect this interface.
> This will enable all JTAG drivers to use the common interface
> part and will have separate for hardware implementation.

Let's consider I want to get rid of OpenOCD, or rather, move its driver
interface within the kernel and replace it on the OpenOCD side with a
generic character device interface. I could presumably amortize the
costly operations which are currently I/O and/or system call limiting
when running in user-space, what would it look like with your proposed
framework, have you given some thoughts about that?

Thanks!
-- 
Florian
