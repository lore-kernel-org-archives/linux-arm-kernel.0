From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 4 Oct 2017 11:41:35 -0700
Subject: [PATCH] arm64: Enforce endianness build flags for LD and AS
In-Reply-To: <20171004183108.GA10699@roeck-us.net>
References: <1507064302-3972-1-git-send-email-linux@roeck-us.net>
 <20171004183108.GA10699@roeck-us.net>
Message-ID: <20171004184135.GA12348@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 04, 2017 at 11:31:08AM -0700, Guenter Roeck wrote:
> On Tue, Oct 03, 2017 at 01:58:22PM -0700, Guenter Roeck wrote:
> > If LD or AS is specified on the command line using "make LD=<my-ld>",
> > the endianness flag will not be added. Depending on the toolchain used,
> > this can result in endianness mismatch errors, such as
> > 
> > aarch64-cros-linux-gnu/binutils-bin/2.27.0/ld.bfd.real:
> > arch/arm64/crypto/.tmp_aes-ce-cipher.o:
> > 	compiled for a big endian system and target is little endian
> > 
> > The problem was observed when using the Chrome OS build system (which sets
> > LD on the command line) for an arm64:allmodconfig build.
> > 
> > Use the override flag for both LD and AS to ensure that the endianness
> > flag is always set.
> > 
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Please ignore this patch for now; it doesn't help with my problem. Not yet
> sure what happens, but it appears that "-EB" doesn't make it into the LD
> variable used by cmd_make_builtin in scripts/Makefile.build. I'll have
> to figure out what is going on.
> 
Yes, the problem is that the gcc in the Chrome OS toolchain doesn't tell
the linker which endianness to use (ie it doesn't translate -mbig-endian 
into a linker flag). Please forget this patch, it doesn't solve anything.
Sorry for the noise.

Guenter
