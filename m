From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 9 May 2017 15:59:27 +0100
Subject: Updating kernel.org cross compilers?
In-Reply-To: <20170430052957.GJ19687@gate.crashing.org>
References: <92b5ff36-ad2b-10bc-de4f-4774babd9625@arm.com>
 <20170430052957.GJ19687@gate.crashing.org>
Message-ID: <ee8a7f2c-976d-fe2a-55f9-ab8eebbf22eb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/04/17 06:29, Segher Boessenkool wrote:

Hi,

> On Wed, Apr 26, 2017 at 03:14:16PM +0100, Andre Przywara wrote:
>> It seems that many people (even outside the Linux kernel community) use
>> the cross compilers provided at kernel.org/pub/tools/crosstool.
>> The latest compiler I find there is 4.9.0, which celebrated its third
>> birthday at the weekend, also has been superseded by 4.9.4 meanwhile.
>>
>> So I took Segher's buildall scripts from [1] and threw binutils 2.28 and
>> GCC 6.3.0 at them.
> 
> Happy to see people are still using these!
> 
>> After removing --enable-sjlj-exceptions from build-gcc
> 
> This was needed to build some targets.  It does prevent aarch64 from
> building without patch.

I saw you fixing that in your repo, thanks for that!

>> and adding --disable-multilib (for building x86-64 on a x86-64
>> box without 32-bit libs)
> 
> Why is this needed?  What error are you seeing.

It was something along the lines of not finding 32-bit compat libraries
(which I don't have on that build machine):
------------------------
configure: error: I suspect your system does not have 32-bit development
libraries (libc and headers). If you have them, rerun configure with
--enable-multilib. If you do not have them, and want to build a
64-bit-only compiler, rerun configure with --disable-multilib.
------------------------

I don't think we need multilib for a kernel build, also we have an i386
compiler for 32-bit kernels. So adding this flags allows x86_64 to be
build on pure 64-bit systems.

>> I was able to build (bare-metal) toolchains for
>> all architectures except arc, m68k, tilegx and tilepro.
> 
> arc needs a more recent GCC; the other probably as well.  GCC 7 should
> be out very soon, you probably want to wait for that :-)

Well, GCC 7 indeed builds better, but then again is a very new compiler.
For instance in the moment it spits a lot of warnings when compiling the
kernel (mostly due to some *printf analysis). It's not hard to fix, but
this will take a while to trickle in and it's questionable whether this
will be backported everywhere.
So in addition to GCC 7.1 I'd like to have at least GCC 6.3 around,
which builds kernels without warnings today.

For GCC 6.3 (and probably before) arc was breaking because missing a
(default) CPU type. Adding "--with-cpu=arc700" to EXTRA_GCC_CONF fixed
that, but GCC 7 indeed builds fine, even without it.
I was wondering if we could have that flags added to the new
TARGET_GCC_CONF variable for arc-elf, to cover pre GCC 7 compilers.

>> $ ./buildall --toolchain
>> $ PATH=$PATH:/opt/cross/bin
>> $ ./buildall --kernel
> 
> You should have the target dir in your PATH before doing anything else.
> Is this not documented?  Hrm I guess not, let me fix that.
> 
>> And what is a good build setup, so that the binaries run on as many
>> systems as possible?
> 
> Run contrib/download_prerequisites in the gcc source dir: this will
> make GMP, MPFR, MPC statically linked, and use a version of each that
> is known to work (and work correctly).

Ah, that's a good hint! Thanks, that solves a lot of problems.

Also I removed documentation (share/ directory, which won't be in
MANPATH mostly anyway) from the tarball and stripped the (host) binaries
to get the tarball size down (to about 16 MB per arch)

I built both toolchains and kernels for almost all 31 supported
architectures. Some kernel builds fails (sparc, sparc64, arc), but not
due to toolchain issues, as it seems. Only sh4 complains:
sh4-linux-gcc: error: command line option '-m4-nofpu' is not supported
by this configuration.

So while I have now 31 GCC 7.1.0 tarballs, pushing those binaries to
some public webspace raises some legal eyebrows here, so I was wondering
if someone (probably with less affiliation to a hardware (arch) vendor)
could build, package and upload them? I am happy to assist with that
process.

Cheers,
Andre.

>> [1] http://git.infradead.org/users/segher/buildall.git/
> 
> I'll push some changes that make aarch64 work out-of-the-box in a
> minute.  It does some other things as well (e.g., make ia64 work again
> after *that* change); more changes are still needed to make sh4 work
> without patches.
> 
> 
> Segher
> 
