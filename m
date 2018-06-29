From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 29 Jun 2018 15:27:30 +0000
Subject: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
In-Reply-To: <20180628144858.2fu7kq56cxhp2kpg@armageddon.cambridge.arm.com>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <0cef1643-a523-98e7-95e2-9ec595137642@arm.com>
 <20180627171757.amucnh5znld45cpc@armageddon.cambridge.arm.com>
 <20180628061758.j6bytsaj5jk4aocg@ltop.local>
 <20180628102741.vk6vphfinlj3lvhv@armageddon.cambridge.arm.com>
 <20180628104610.czsnq4w3lfhxrn53@ltop.local>
 <20180628144858.2fu7kq56cxhp2kpg@armageddon.cambridge.arm.com>
Message-ID: <a53c13e0cff941aa85f023b0f29346af@AcuMS.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas
> Sent: 28 June 2018 15:49
...
> >
> > Mmmm yes.
> > I tend to favor a sort of opposite approach. When we have an address
> > that must not be dereferenced as-such (and sometimes when the address
> > can be from both __user & __kernel space) I prefer to use a ulong
> > which will force the use of the required operation before being
> > able to do any sort of dereferencing and this won't need horrible
> > casts with __force (it, of course, all depends on the full context).
> 
> I agree. That's what the kernel uses in functions like get_user_pages()
> which take ulong as an argument. Similarly mmap() and friends don't
> expect the pointer to be dereferenced, hence the ulong argument. The
> interesting part that the man page (and the C library header
> declaration) shows such address argument as void *. We could add a
> syscall wrapper in the arch code, only that it doesn't feel consistent
> with the "rule" that ulong addresses are not actually tagged pointers.

For most modern calling conventions it would make sense to put 'user'
addresses (and physical ones from that matter) into a structure.
That way you get much stronger typing from C itself.

The patch would, of course, be huge!

	David
