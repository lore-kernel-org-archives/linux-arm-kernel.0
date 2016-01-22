From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jan 2016 17:48:14 +0000
Subject: Unhandled fault: page domain fault (0x81b) at 0x00e41008
In-Reply-To: <56A268E7.7040004@free.fr>
References: <56A268E7.7040004@free.fr>
Message-ID: <20160122174814.GD19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2016 at 06:37:43PM +0100, Mason wrote:
> Hello,
> 
> I'm hitting
> Unhandled fault: page domain fault (0x81b) at 0x00e41008
> 
> which is related to CPU_SW_DOMAIN_PAN
> commit a5e090acbf545c0a3b04080f8a488b17ec41fe02
> 
> 
> I see that __copy_from_user() is now wrapped in
> uaccess_save_and_enable ... uaccess_restore
> 
> I'm not using __copy_from_user() because I'm implementing block
> copies with specific access size.
> 
> Can I just wrap my block copy functions in
> uaccess_save_and_enable ... uaccess_restore
> like __copy_from_user?

No, you _must_ use the correct functions to access userspace.
Userspace accesses are marked in a special way that allows the kernel
to fix up non-present pages.  Normal accesses may appear to work but
will eventually oops the kernel when the page is unmapped or is marked
read-only and you try to write to it.

Please don't think of using __copy_from_user() et.al. either - those
are there for code which knows what it's doing and has pre-validated
the accesses.

Drivers and platform code should use copy_from_user()/copy_to_user()
to block-copy data to/from userspace, and get_user()/put_user() to
copy individual bytes, shorts and int/longs.  (It doesn't matter
who you are, that's the official guidance.)

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
