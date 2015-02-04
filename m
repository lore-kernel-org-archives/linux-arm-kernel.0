From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Feb 2015 16:25:36 +0000
Subject: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <CAErSpo71fVU5mJgXnxMwiE_TUrNyfSYHo5RDF-=u2BK5grDYAw@mail.gmail.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <2422968.Es7R0p3loO@vostro.rjw.lan>
 <1422984576.18187.82.camel@deneb.redhat.com>
 <8901765.mLfPOCUyAN@vostro.rjw.lan>
 <20150204104832.GF8656@n2100.arm.linux.org.uk>
 <CAErSpo71fVU5mJgXnxMwiE_TUrNyfSYHo5RDF-=u2BK5grDYAw@mail.gmail.com>
Message-ID: <20150204162536.GJ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 09:53:28AM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 4, 2015 at 4:48 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Moreover, __weak is positively harmful when you consider it adds bloat
> > and dead code - the overriden __weak function is left behind in the
> > resulting final image.
> 
> Huh, I didn't realize that.  Is that a linker bug, or is there some
> reason the weak function has to be in the final image?  I tried a
> trivial test on x86 with gcc-4.8.2/ld-2.24, and I think the weak
> function text was omitted, but a string constant used only by the weak
> function was included.

Try this:

t1.c:
int a;
void __weak function(void)
{
	a = 1;
}

int main()
{
	return 0;
}

t2.c:
extern int a;
void function(void)
{
	a = 2;
}

gcc -O2 -o t12 t1.c t2.c

What I get is:

08048370 <frame_dummy>:
...
 80483a0:       55                      push   %ebp
 80483a1:       89 e5                   mov    %esp,%ebp
 80483a3:       c7 05 34 96 04 08 01    movl   $0x1,0x8049634
 80483aa:       00 00 00
 80483ad:       5d                      pop    %ebp
 80483ae:       c3                      ret
 80483af:       90                      nop

That's the code which used to be "function" in t1.c (notice it assigning
1 to 0x8049634).

080483b0 <main>:
 80483b0:       55                      push   %ebp
 80483b1:       31 c0                   xor    %eax,%eax
 80483b3:       89 e5                   mov    %esp,%ebp
 80483b5:       5d                      pop    %ebp
 80483b6:       c3                      ret

080483c0 <function>:
 80483c0:       55                      push   %ebp
 80483c1:       89 e5                   mov    %esp,%ebp
 80483c3:       c7 05 34 96 04 08 02    movl   $0x2,0x8049634
 80483ca:       00 00 00
 80483cd:       5d                      pop    %ebp
 80483ce:       c3                      ret

There's the non-weak version, assigning 2 to 0x8049634.

You have to look carefully for the weak version, because the linker
will omit its symbol.

The reason this happens is because normally, each function text is
emitted into the .text section of the object file, one after each
other.  When the image is linked, the linker copies the contents of
the complete input section to the output file, and then resolves the
symbolic information and relocations.

There is a way around this - the gcc -ffunction-sections flag, which
causes each function to be emitted into a separate section, and then
in conjunction with the --gc-sections linker flag, the linker can
remove unreferenced input sections from the output file.

This also has the effect that unreferenced functions will also be
removed from the output file - using --gc-sections may also result
in the linker-built sections (such as the initcall list) being gc'd
away.

I haven't experimented with it myself, but I think David Woodhouse
has some experience in this area.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
