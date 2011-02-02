From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 01 Feb 2011 23:11:50 -0500 (EST)
Subject: advice needed on how best to fix kirkwood kexec
In-Reply-To: <20110201215059.GC7547@localhost>
References: <20110201215059.GC7547@localhost>
Message-ID: <alpine.LFD.2.00.1102012252520.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Feb 2011, Eric Cooper wrote:

> I found the problem with kexec'ing kirkwood kernels:
> 
> During late initialization, the kirkwood_clock_gate function powers
> down unused units, including the PCIe.  But the early initialization
> (kirkwood_timer_init) relies on reading the device ID register, which
> is in the PCIe space, so it will hang when started by kexec.
> 
> My question is, should I patch the kexec code or the initialization code?
> 
> Patching the kexec code is much more useful, because it allows
> kexec'ing the existing kirkwood kernels that are already "out there",
> in distros, etc.  But it requires a kirkwood-specific operation in the
> otherwise generic machine_kexec().
> 
> Patching just the kirkwood initialization is better from an
> "information hiding" perspective, but won't provide any benefit until
> it makes its way into the kernels that people might want to kexec.

I think that both should be patched.  The first one will let you kexec 
old kernels, while the later will let you be kexec'd by old kernels as 
well as be less dependent on whatever the bootloader might have done 
with the clock.

And machine_kexec() should probably call a machine specific hook if set 
by machine specific code, similar to pm_power_off in 
machine_power_off().


Nicolas
