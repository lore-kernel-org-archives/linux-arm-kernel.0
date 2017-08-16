From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 16 Aug 2017 15:19:39 +0200
Subject: next-20170815 build: 2 failures 4 warnings (next-20170815)
In-Reply-To: <13442814.gWUDHvzIl2@aspire.rjw.lan>
References: <E1dhZPk-0002d9-9k@optimist>
 <20170815111612.esq73hxowbw2mehj@sirena.org.uk>
 <13442814.gWUDHvzIl2@aspire.rjw.lan>
Message-ID: <CAMuHMdVKkROQFY-H+RamHcm_oBr10uGOD40d90MyfmdzEFRKRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On Tue, Aug 15, 2017 at 1:59 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, August 15, 2017 1:16:12 PM CEST Mark Brown wrote:
>> --xqegarazqzvkdxmo
>> Content-Type: text/plain; charset=us-ascii
>> Content-Disposition: inline
>>
>> On Tue, Aug 15, 2017 at 11:49:36AM +0100, Build bot for Mark Brown wrote:
>>
>> Today's -next fails to build on arm64 due to:
>>
>> >     arm64-allmodconfig
>> >     arm64-defconfig
>> > ../drivers/acpi/spcr.c:168:1: error: expected expression before '<<' token
>> > ../drivers/acpi/spcr.c:198:1: error: expected expression before '>>' token
>>
>> caused by f69ba1326ac33b (Merge branch 'acpi-spcr' into linux-next)
>> which has an unresolved conflict in it.
>
> Yes, I broke this, sorry.
>
> Will fix it shortly.

The rebased version (fix?) lacks a curly opening brace.
Gmail-whitespace-damaged patch to fold into the bad version below.

>From f5d55ccb53f02b67be52962d727bdfe3fff14afb Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 16 Aug 2017 15:17:35 +0200
Subject: [PATCH] CPI: SPCR: Add missing opening brace

drivers/acpi/spcr.c: In function 'parse_spcr':
drivers/acpi/spcr.c:165:3: error: label 'done' used but not defined
   goto done;
   ^
drivers/acpi/spcr.c: At top level:
drivers/acpi/spcr.c:201:4: error: expected identifier or '(' before 'else'
  } else {
    ^
drivers/acpi/spcr.c:206:9: error: expected declaration specifiers or
'...' before string constant
  pr_info("console: %s\n", opts);
         ^
drivers/acpi/spcr.c:206:52: error: unknown type name 'opts'
  pr_info("console: %s\n", opts);
                                                    ^
drivers/acpi/spcr.c:208:2: error: expected identifier or '(' before 'if'
  if (earlycon)
  ^
drivers/acpi/spcr.c:211:2: warning: data definition has no type or storage class
  err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
  ^
drivers/acpi/spcr.c:211:2: error: type defaults to 'int' in
declaration of 'err' [-Werror=implicit-int]
drivers/acpi/spcr.c:211:30: error: 'uart' undeclared here (not in a function)
  err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
                              ^
drivers/acpi/spcr.c:211:39: error: 'opts' undeclared here (not in a function)
  err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
                                       ^
drivers/acpi/spcr.c:213:5: error: expected '=', ',', ';', 'asm' or
'__attribute__' before ':' token
 done:
     ^
drivers/acpi/spcr.c:215:2: error: expected identifier or '(' before 'return'
  return err;
  ^
drivers/acpi/spcr.c:216:1: error: expected identifier or '(' before '}' token
 }
 ^
drivers/acpi/spcr.c: In function 'parse_spcr':
drivers/acpi/spcr.c:201:2: warning: control reaches end of non-void
function [-Wreturn-type]
  } else {
  ^

Fixes: fd46b1aebee729fb ("ACPI: SPCR: work around clock issue on xgene UART")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/acpi/spcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 617003032415e09e..324b35bfe781d42a 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -189,7 +189,7 @@ int __init parse_spcr(bool earlycon)
  uart = "qdf2400_e44";
  }

- if (xgene_8250_erratum_present(table))
+ if (xgene_8250_erratum_present(table)) {
  iotype = "mmio32";

  /* for xgene v1 and v2 we don't know the clock rate of the
-- 
2.7.4

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
