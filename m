From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Dec 2011 20:45:15 +0000
Subject: insmod problem on ARM with more than 16MB of RAM?
In-Reply-To: <CAHkRjk7105PLe=98mMKmSKkWDmyFjWpBkZ5_iy-U-ZiNKHFNLw@mail.gmail.com>
References: <20111222203531.0c4f80f1@emcraft.com>
 <CAHkRjk7105PLe=98mMKmSKkWDmyFjWpBkZ5_iy-U-ZiNKHFNLw@mail.gmail.com>
Message-ID: <20111222204515.GQ2577@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 04:49:13PM +0000, Catalin Marinas wrote:
> A completely generic solution would be to modify the module loader to
> cope with longer relocations by setting up some trampoline code.

That was discussed when the module format changed, and decided it was
not possible because of circular dependencies to do it right.

The reason is you can't modify the size of the allocation after the
module has been loaded to add trampolines, and you can't parse the
object file until memory has been allocated to load it into.  So you
either have to allocate a trampoline for every function symbol in the
kernel which the module _might_ use (which wastes lots of memory) or
you just arrange for stuff to be placed within range of the kernel.

So for MMU platforms, we just ensure that modules are always placed
within reach of the kernel text.  For nommu platforms, modules are
a bitch - and TBH given the virtually non-existent activity/interest
from the nommu sector, it's something I'm willing to spend the grand
total of zero time to solve this _really_ _hard_ problem.
