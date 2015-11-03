From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 3 Nov 2015 08:57:05 -0600
Subject: [PATCH 10/11] tty: amba-pl011: add support for 32-bit register
 access
In-Reply-To: <E1Ztcw4-0007Ct-PP@rmk-PC.arm.linux.org.uk>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
 <E1Ztcw4-0007Ct-PP@rmk-PC.arm.linux.org.uk>
Message-ID: <5638CB41.1000807@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> -	return readw(uap->port.membase + pl011_reg_to_offset(uap, reg));
> +	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
> +
> +	return uap->access_32b ? readl(addr) : readw(addr);

Ok, ignore my previous email.  I just noticed this.

This version is fine, except that it now performs a runtime check for 
every I/O access.  Isn't that too much overhead?  access_32b will always 
be either True or False for the life of the entire SOC.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
