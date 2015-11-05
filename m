From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Nov 2015 09:46:15 +0000
Subject: [PATCH] arm: Use kernel mm when updating section permissions
In-Reply-To: <1446685239-28522-1-git-send-email-labbott@fedoraproject.org>
References: <1446685239-28522-1-git-send-email-labbott@fedoraproject.org>
Message-ID: <20151105094615.GP8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 05:00:39PM -0800, Laura Abbott wrote:
> Currently, read only permissions are not being applied even
> when CONFIG_DEBUG_RODATA is set. This is because section_update
> uses current->mm for adjusting the page tables. current->mm
> need not be equivalent to the kernel version. Use pgd_offset_k
> to get the proper page directory for updating.

What are you trying to achieve here?  You can't use these functions
at run time (after the first thread has been spawned) to change
permissions, because there will be multiple copies of the kernel
section mappings, and those copies will not get updated.

In any case, this change will probably break kexec and ftrace, as
the running thread will no longer see the updated page tables.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
