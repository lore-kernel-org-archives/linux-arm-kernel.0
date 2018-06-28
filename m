From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Jun 2018 11:27:42 +0100
Subject: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
In-Reply-To: <20180628061758.j6bytsaj5jk4aocg@ltop.local>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <0cef1643-a523-98e7-95e2-9ec595137642@arm.com>
 <20180627171757.amucnh5znld45cpc@armageddon.cambridge.arm.com>
 <20180628061758.j6bytsaj5jk4aocg@ltop.local>
Message-ID: <20180628102741.vk6vphfinlj3lvhv@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 08:17:59AM +0200, Luc Van Oostenryck wrote:
> On Wed, Jun 27, 2018 at 06:17:58PM +0100, Catalin Marinas wrote:
> > sparse is indeed an option. The current implementation doesn't warn on
> > an explicit cast from (void __user *) to (unsigned long) since that's a
> > valid thing in the kernel. I couldn't figure out if there's any other
> > __attribute__ that could be used to warn of such conversion.
> 
> sparse doesn't have such attribute but would an new option that would warn
> on such cast be a solution for your case?

I can't tell for sure whether such sparse option would be the full
solution but detecting explicit __user pointer casts to long is a good
starting point. So far this patchset pretty much relies on detecting
a syscall failure and trying to figure out why, patching the kernel. It
doesn't really scale.

As a side note, we have cases in the user-kernel ABI where the user
address type is "unsigned long": mmap() and friends. My feedback on an
early version of this patchset was to always require untagged pointers
coming from user space on such syscalls, so no need for explicit
untagging.

-- 
Catalin
