From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 27 Jan 2015 15:25:36 +0000
Subject: Kexec and KVM not working gracefully together
In-Reply-To: <CAHt6W4cuRi3bfj5mryFouhOLGAAWuNXKVvz4K-rAjQnwiegL-Q@mail.gmail.com>
References: <CAHt6W4cuRi3bfj5mryFouhOLGAAWuNXKVvz4K-rAjQnwiegL-Q@mail.gmail.com>
Message-ID: <54C7ADF0.8090102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frediano,

On 27/01/15 15:07, Frediano Ziglio wrote:
> Hi,
>   I was trying to make kexec (software reset) work on an ARM platform
> and I realized that the kernel launched with kexec cannot use KVM.
> Looking for message I get from kernel and code the situation is this:
> 1- kernel start in HYP mode but then kvm code switch to SVC mode and
> initialize HYP mode with its code;
> 2- kexec call reboot with LINUX_REBOOT_CMD_KEXEC
> 3- kernel call kernel_exec;
> 4- kernel_exec calls machine_kexec;
> 5- machine_kexec calls soft_restart passing physical entry point for
> next in memory kernel;
> 6- soft_restart calls __soft_restart changing stack;
> 7- __soft_restart calls cpu_reset (which in my case is defined as cpu_v7_reset);
> 8- cpu_v7_reset just disable MMU (it's in an identity memory) and
> calls next kernel entry point.
> 
> From point 3 to 8 kernel is always in SVC mode so next kernel is
> launched in SVC mode too but initial kernel was launched in HYP mode.
> 
> I used kernel 3.14 but looking at 3.19 rc code there is the same issue
> (code didn't change).
> 
> Using hvc instruction you can execute arbitrary functions however
> these function must be in a very restricted range as HYP code MMU has
> very limited paged configured and cpu_v7_reset is not one of these
> functions.
> 
> My idea to fix the issue is before calling cpu_reset call a new
> kvm_exit or similar that turn into HYP mode with MMU set as SVC mode.
> 
> Is this a known issue? Should I try to fix the problem or somebody can
> easily fix it?

This has been known for a while, and so far people dealing with Kexec
have preferred sidestepping the issue. This is moderately easy to fix if
you're happy dealing with page tables. What is missing is the code that
switches back to an idmap, restore the HYP stubs, and let Kexec install
its own stubs for jumping to the next kernel.

Most of the infrastructure is already there, it is "just" a matter of
getting it right.

If you feel like giving it a go, I suggest you have a look at how we
actually install KVM (the transitions from no MMU to idmap to trampoline
page to final layout is rather entertaining). Once you understand that,
it should be rather straightforward to perform this in the reverse
order, and we can assist you getting it right.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
