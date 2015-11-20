From: keescook@chromium.org (Kees Cook)
Date: Fri, 20 Nov 2015 12:45:02 -0800
Subject: [RFC PATCH] restrict /dev/mem to idle io memory ranges
In-Reply-To: <CAPcyv4hagUwc3AJuDHvBy+YR1Khv+5uUL0HZawO9R0r-EZLVHg@mail.gmail.com>
References: <20151120173133.24259.97028.stgit@dwillia2-desk3.jf.intel.com>
 <20151120201207.GH8644@n2100.arm.linux.org.uk>
 <CAPcyv4hagUwc3AJuDHvBy+YR1Khv+5uUL0HZawO9R0r-EZLVHg@mail.gmail.com>
Message-ID: <CAGXu5jJ_Q4LLoaw=MHBDQVH0QuOFDvzwK5hhVN94n4AHWhARZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 12:26 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Fri, Nov 20, 2015 at 12:12 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Fri, Nov 20, 2015 at 09:31:33AM -0800, Dan Williams wrote:
>>> This effectively promotes IORESOURCE_BUSY to IORESOURCE_EXCLUSIVE
>>> semantics by default.  If userspace really believes it is safe to access
>>> the memory region it can also perform the extra step of disabling an
>>> active driver.  This protects device address ranges with read side
>>> effects and otherwise directs userspace to use the driver.
>>
>> I'm happy with this as long as we retain the option to disable this
>> new behaviour.
>>
>> The reason being, when developing a driver, it is _very_ useful to
>> be able to poke around in the device's (and system memory) address
>> spaces with tools like devmem2 to work out what's going on when
>> things go wrong.
>>
>> To put it another way, I think it's a good idea to disable access to
>> these regions on production systems, but for driver development, we
>> want to retain the ability to poke around in physical address space
>> in any way we so desire.
>>
>
> Sounds ok to me, but I do think it's a good idea to default it to the
> same value as STRICT_DEVMEM.  Perhaps:
>
> bool "Filter I/O access to /dev/mem" if EXPERT
> default STRICT_DEVMEM
>
> When this in do we even need IORESOURCE_EXCLUSIVE?  It's barely used.

Let's leave it for now to give us the debugging granularity Russell
mentioned. If it turns out it's never used, we can drop it in the
future.

-Kees

-- 
Kees Cook
Chrome OS Security
