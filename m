From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Feb 2016 16:40:54 +0100
Subject: [PATCH v2 0/5] arm64: kernel: Add support for User Access Override
In-Reply-To: <1454684330-892-1-git-send-email-james.morse@arm.com>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
Message-ID: <13475776.5b1DTHhHh9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 February 2016 14:58:45 James Morse wrote:
> This series adds support for User Access Override (UAO; part of the ARMv8.2
> Extensions[0]). When enabled, this causes the get_user() accessors to use
> the unprivileged load/store instructions. When addr_limit is set to
> KERNEL_DS, we set the override bit allowing privileged access.
> 
> Because the unprivileged instructions don't trip PAN, the last patch changes
> which 'alternative' values are swapped in, allowing PAN to be left enabled
> during get_user() and friends.
> 
> This series can be retrieved from:
> git://linux-arm.org/linux-jm.git -b uao/v2
> 

Looks very nice. I have no complaints about the implementations, but two questions:

* There was recently some work in reducing the number of set_fs() calls in
  the compat_ioctl, which further reduces the attack surface. Should we try to
  continue that effort in other syscalls?

* Do we expect to handle this using live patching indefinitely? I can imagine
  that at some point in the future, ARMv8.2+ systems will be the vast majority,
  so it might be nice to support enabling it unconditionally (same for any
  of the alternative bits really). Is there a long-term strategy?

	Arnd
