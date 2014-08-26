From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Aug 2014 13:32:23 +0200
Subject: [PATCH 5/6] arm64: Port SWP/SWPB emulation support from arm
In-Reply-To: <1409048930-21598-6-git-send-email-punit.agrawal@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
 <1409048930-21598-6-git-send-email-punit.agrawal@arm.com>
Message-ID: <7433994.DUuXUlazW0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 August 2014 11:28:49 Punit Agrawal wrote:
> 
> This patch ports the alternative solution to emulate the SWP and SWPB
> instructions using LDXR/STXR sequences from the arm port to
> arm64. Additionaly, the patch also proivdes support to log the
> emulation statistics via debugfs.

I'm not sure that putting this into debugfs is a good idea in this
case: while in general that is considered a good place for this
kind of debugging information, we already have a precedent on arm32
for using procfs, and I see no reason to introduce an incompatible
interface for arm64.

You also add an interface for disabling the feature at runtime,
which we don't have on arm32, but that interface is not available
if debugfs is disabled or not mounted. Maybe a sysctl would be
more appropriate? That one could also be shared with arm32.

> +       swp_d = debugfs_create_dir("swp_emulation", arch_debugfs_dir);
> +       if (!IS_ERR_OR_NULL(swp_d)) {

Never use IS_ERR_OR_NULL(). It's enough to check for !swp_d here,
since debugfs_create_dir returns NULL on error. You don't need to
check for debugfs being disabled here because you don't do anything
in the conditional code block if it is disabled. 

	Arnd
