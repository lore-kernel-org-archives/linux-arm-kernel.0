From: james.morse@arm.com (James Morse)
Date: Thu, 19 Jul 2018 12:31:13 +0100
Subject: [PATCH] arm64, kaslr: export offset in VMCOREINFO ELF notes
In-Reply-To: <1531949864-27447-1-git-send-email-bhsharma@redhat.com>
References: <1531949864-27447-1-git-send-email-bhsharma@redhat.com>
Message-ID: <d8959ca1-65a1-f59c-bfc4-b048c75add26@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bhupesh,

On 18/07/18 22:37, Bhupesh Sharma wrote:
> Include KASLR offset in VMCOREINFO ELF notes to assist in debugging.
> 
> makedumpfile user-space utility will need fixup to use this KASLR offset
> to work with cases where we need to find a way to translate symbol
> address from vmlinux to kernel run time address in case of KASLR boot on
> arm64.

You need the kernel VA for a symbol. Isn't this what kallsyms is for?
| root at frikadeller:~# cat /proc/kallsyms | grep swapper_pg_dir
| ffff5404610d0000 B swapper_pg_dir

This is the KASLR address, the vmlinux has:
| root at frikadeller:~/linux/build_arm64# nm -s vmlinux | grep swapper_pg_dir
| ffff0000096d0000 B swapper_pg_dir


This is in the vmcoreinfo too, so you can work if out from the vmcore too:
| root at frikadeller:~# dd if=/proc/kcore bs=8K count=1 2>/dev/null | strings |
| grep swapper_pg_dir
| SYMBOL(swapper_pg_dir)=ffff5404610d0000


I picked swapper_pg_dir, but you could use any of the vmcore:SYMBOL() addresses
to work out this offset. (you should expect the kernel to rename these symbols
at a whim).


Thanks,

James
