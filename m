From: dianders@chromium.org (Doug Anderson)
Date: Tue, 3 Oct 2017 14:04:09 -0700
Subject: [PATCH] arm64: Enforce endianness build flags for LD and AS
In-Reply-To: <1507064302-3972-1-git-send-email-linux@roeck-us.net>
References: <1507064302-3972-1-git-send-email-linux@roeck-us.net>
Message-ID: <CAD=FV=XWy3mucLSCsDy8f9ORVHg+UJa0idE=59=XiPDxubDjJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 3, 2017 at 1:58 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> If LD or AS is specified on the command line using "make LD=<my-ld>",
> the endianness flag will not be added. Depending on the toolchain used,
> this can result in endianness mismatch errors, such as
>
> aarch64-cros-linux-gnu/binutils-bin/2.27.0/ld.bfd.real:
> arch/arm64/crypto/.tmp_aes-ce-cipher.o:
>         compiled for a big endian system and target is little endian
>
> The problem was observed when using the Chrome OS build system (which sets
> LD on the command line) for an arm64:allmodconfig build.
>
> Use the override flag for both LD and AS to ensure that the endianness
> flag is always set.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/arm64/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

This seems right to me.  My understanding of the way things work is
that if you want a different linker or assembler you pass it on the
command line.  That means you need "override" like this if you want to
append to it.

As a self-proclaimed non-expert on the kernel build system I'm not
sure it's worth much, but in any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
