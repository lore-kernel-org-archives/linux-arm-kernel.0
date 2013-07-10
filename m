From: markus@trippelsdorf.de (Markus Trippelsdorf)
Date: Wed, 10 Jul 2013 20:28:15 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130710093642.GC14873@pd.tnic>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <1367829775-4434-2-git-send-email-kyungsik.lee@lge.com>
 <20130506095124.GA22041@pd.tnic>
 <CAMuHMdWH9w5fj6HRXi+9QcBJym4dukAFsPVGZVqSSk3yTZJUcA@mail.gmail.com>
 <20130710093642.GC14873@pd.tnic>
Message-ID: <20130710182815.GA362@x4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013.07.10 at 11:36 +0200, Borislav Petkov wrote:
> On Wed, Jul 10, 2013 at 10:12:46AM +0200, Geert Uytterhoeven wrote:
> > >> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > >> index a0ab6d7..c9bfbb0 100644
> > >> --- a/scripts/Makefile.lib
> > >> +++ b/scripts/Makefile.lib
> > >> @@ -313,7 +313,7 @@ cmd_lzo = (cat $(filter-out FORCE,$^) | \
> > >>
> > >>  quiet_cmd_lz4 = LZ4     $@
> > >>  cmd_lz4 = (cat $(filter-out FORCE,$^) | \
> > >> -     lz4demo -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
> > >> +     lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
> > >
> > > You probably want to check for the presence of lz4c on the system and
> > > bail with an informative message if absent.
> > 
> > Yep, x86_64-randconfig
> > (http://kisskb.ellerman.id.au/kisskb/buildresult/9110794/):
> > 
> >   LZ4     arch/x86/boot/compressed/vmlinux.bin.lz4
> > /bin/sh: lz4c: command not found
> 
> Sure, it had to be 2 months and to hit upstream for there still to be no
> fix. Geez...

Well, there's also no hand-holding when lzop is missing for LZO.
And the error message is clear enough. No?

BTW speaking of introductory-level patches, what about the following
one:

Now that lz4 kernel compression is available, add *.lz4 to .gitignore

diff --git a/.gitignore b/.gitignore
index 3b8b9b3..7e9932e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -29,6 +29,7 @@ modules.builtin
 *.bz2
 *.lzma
 *.xz
+*.lz4
 *.lzo
 *.patch
 *.gcno


-- 
Markus
