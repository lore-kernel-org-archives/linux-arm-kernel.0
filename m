From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 7 Apr 2017 17:22:39 +0100
Subject: [kernel-hardening] Re: [RFC v2][PATCH 04/11] x86: Implement
 __arch_rare_write_begin/unmap()
In-Reply-To: <CALCETrWuZPDjAuE1jnhJNKiZOOEdbus-O6GY8++0UO56Q84PZw@mail.gmail.com>
References: <CAGXu5jKif5UUMBbQBpB7Ha7w0L+su8dSXDU3nbccO3EBnv7bTw@mail.gmail.com>
 <CALCETrW7nN8Ja=r9k4ANpekKovC_wsYrGrge1WNoGsAjZZvqHQ@mail.gmail.com>
 <CAGXu5jLENkemQiL6bcL5=qsesi-2M=1jYhS7SGBpBG64ER2CsA@mail.gmail.com>
 <CALCETrVErxE5P=V4LD=kFCBtnp2YYEGRsbxhTG0SXJjrw6Yk1A@mail.gmail.com>
 <CA+rthh95rW95woiWvyeCcoJT-qRM18KCDGHGtH=bDHZdExmVmg@mail.gmail.com>
 <alpine.DEB.2.20.1704071048360.1716@nanos>
 <CA+rthh9-EJBBO6nYYY6noP0ybcvk+xJ+S5h6BCNPtidjMCv8VQ@mail.gmail.com>
 <alpine.DEB.2.20.1704071426300.1716@nanos>
 <CA+rthh8TbqU-4tY4Y8trnyMDBe6dRLhVrAnk-COJCZCOyHqSog@mail.gmail.com>
 <CALCETrWuZPDjAuE1jnhJNKiZOOEdbus-O6GY8++0UO56Q84PZw@mail.gmail.com>
Message-ID: <20170407162238.GD858@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 07, 2017 at 09:14:29AM -0700, Andy Lutomirski wrote:
> I think we're approaching this all wrong, actually.  The fact that x86
> has this CR0.WP thing is arguably a historical accident, and the fact
> that PaX uses it doesn't mean that PaX is doing it the best way for
> upstream Linux.
> 
> Why don't we start at the other end and do a generic non-arch-specific
> implementation: set up an mm_struct that contains an RW alias of the
> relevant parts of rodata and use use_mm to access it.  (That is,
> get_fs() to back up the old fs, set_fs(USER_DS),
> use_mm(&rare_write_mm), do the write using copy_to_user, undo
> everything.)

FWIW, I completely agree with this approach.

That's largely the approach arm64 would have to take regardless (as per
Hoeun's patches), and having a consistent common implementation would be
desireable.

There are a couple of other complications to handle (e.g. a perf
interrupt coming in and trying to read from the mapping), but I think we
can handle that generically.

Thanks,
Mark.
