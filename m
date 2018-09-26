From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Sep 2018 09:25:26 +0200
Subject: [PATCH v2] ARM: use choice for kernel unwinders
In-Reply-To: <20180925212018.27132-1-stefan@agner.ch>
References: <20180925212018.27132-1-stefan@agner.ch>
Message-ID: <CAK8P3a3naNgsWRLCyMbACntte4DOaYz3tzP72SMZGDzaUoZtPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 11:20 PM Stefan Agner <stefan@agner.ch> wrote:
>
> While in theory multiple unwinders could be compiled in, it does
> not make sense in practise. Use a choice to make the unwinder
> selection mutually exclusive and mandatory.
>
> Already before this commit it has not been possible to deselect
> FRAME_POINTER. Remove the obsolete comment.
>
> Furthermore, to produce a meaningful backtrace with FRAME_POINTER
> enabled the kernel needs a specific function prologue:
>     mov    ip, sp
>     stmfd    sp!, {fp, ip, lr, pc}
>     sub    fp, ip, #4
>
> To get to the required prologue gcc uses apcs and no-sched-prolog.
> This compiler options are not available on clang, and clang is not
> able to generate the required prologue. Make the FRAME_POINTER
> config symbol depending on !clang.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I've tested an earlier version of this patch on my randconfig builder
without issues.

       Arnd
