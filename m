From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Nov 2011 18:51:25 +0000
Subject: 2b034922 breaks kexec on ARM
Message-ID: <20111107185125.GA17464@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I've just finished rebasing and reworking my kexec patches so that they sit
nicely on top of Russell's recent reset work. The only problem is that
commit 2b034922 ("ARM: 7098/1: kdump: copy kernel relocation code at the
kexec prepare stage") is causing kexec to fail.

The symptoms are that the .init.text section is not loaded as part of the
new kernel image, so when we try to do the SMP/UP fixups we hit a whole sea
of poison left there by the previous kernel.

So my guess is that machine_kexec_prepare *is* too early for preparing the
reboot_code_buffer and, unless anybody has a good reason not to, I'd like to
revert the patch causing these problems.

Thanks,

Will
