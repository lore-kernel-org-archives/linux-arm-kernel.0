From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Nov 2014 13:28:28 +0000
Subject: gcc 4.9 build warnings (was: Re: arm-soc build: 2917 warnings 0
 failures (arm-soc/v3.18-rc1-20-g06c0773))
In-Reply-To: <20141106114919.GL26297@ulmo>
References: <544a2a2e.a2db440a.6eeb.ffffaef3@mx.google.com>
 <1847682.hInUtg9rQz@wuerfel>
 <CAKv+Gu_4X0RNbgJ+BCb9+ccgTKBjcwb9L4aDUY6fFMa0R3PX-w@mail.gmail.com>
 <2567100.Zj7YMcXpZG@wuerfel>
 <CAKv+Gu-0jenous5sLPp+QJa3qRk-RiBgG1vVYP_RmVw0uXaysw@mail.gmail.com>
 <20141106114919.GL26297@ulmo>
Message-ID: <20141106132828.GP4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 12:49:22PM +0100, Thierry Reding wrote:
> On Fri, Oct 24, 2014 at 03:41:48PM +0200, Ard Biesheuvel wrote:
> > Ah, ok. So apparently, size_t is not ambiguous between bare metal and
> > glibc GCC, so we are looking at something else here.
> 
> GCC complains about the format specifier being wrong. %zu/%zd are the
> correct specifiers for variables of type size_t/ssize_t, so wherever a
> size_t or ssize_t is used as parameter it should have a corresponding
> %zu or %zd specifier.
> 
> Why not just fix it properly instead of mucking about with the size_t
> typedef?

We haven't been mucking with the size_t typedef.  We've been trying to
find out /why/ GCC 4.9 complains.

For the n'th time, what we know is:

- gcc 4.9 bare metal seems to define __SIZE_TYPE__ to be unsigned int.
- gcc 4.9's stddef.h typedef's size_t to __SIZE_TYPE__.
- therefore, size_t is typedef'd from unsigned int.
- the kernel typedefs __kernel_size_t from unsigned int.
- the kernel typedefs size_t from __kernel_size_t.

So, in theory, size_t in the kernel is unsigned int too.  However, GCC 4.9
issues loads of complains when %zu or %zd is used with a size_t variable
in the kernel.

The question that we've been trying to work out is... why is this?  Right
now, it seems no one has an answer for this question.  We don't know
whether it's a compiler bug or not - and Arnd has explained why not.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
