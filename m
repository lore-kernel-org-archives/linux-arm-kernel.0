From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Mar 2017 15:06:18 +0000
Subject: PSCI reset support - specification
In-Reply-To: <c460a695-1ed3-8926-68c6-09bafb582064@monstr.eu>
References: <c460a695-1ed3-8926-68c6-09bafb582064@monstr.eu>
Message-ID: <20170303150617.GC12945@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 01:09:51PM +0100, Michal Simek wrote:
> Hi,

Hi,

> I have read psci 1.0 specification available here.
> http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/DEN0022C_Power_State_Coordination_Interface.pdf
> 
> I have looked at SYSTEM_RESET where only the first parameter is setup
> which is Function ID (0x8400 0009) and the rest of parameters are not
> setup.

The PSCI SYSTEM_RESET call only has the Function ID parameter, and no
other parameters.

It's not so much that they're not set up, but rather that they do not
exist.

> In Linux kernel we have psci_sys_reset
> 
> static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
> {
> 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
> }
> 
> where others parameters are zeros.
> Is this done by purpose that these zeros are there?

The zeroes are simply an implementation detail of the Linux-internal
invoke_psci_fn() API. As SYSTEM_RESET takes no parameters other than the
Function ID, a PSCI implementation must not treat the remaining
parameter passing register values as meaningful.

It is entirely valid for the above to be changed to:

static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
{
	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET,
	               get_random_long(),
		       get_random_long(),
		       get_random_long());
}

No compliant PSCI implementation should be affected by this.

> Because based on spec these are not used and value is not specified.
> 
> For example u-boot is allocating regs on the stack and others parameters
> have random values.

This is correct. The remaining parameter-passing registers are unused,
and are permitted to contain any value whatsoever when the call is made.

Thanks,
Mark.
