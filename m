From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 17:22:30 +0100
Subject: [PATCH v6 0/6] ARM: vdso gettimeofday using generic timer
 architecture
In-Reply-To: <535926EF.20805@mentor.com>
References: <cover.1398213562.git.nathan_lynch@mentor.com>
 <20140423215040.GC26756@n2100.arm.linux.org.uk> <535926EF.20805@mentor.com>
Message-ID: <20140424162229.GU26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 09:59:59AM -0500, Nathan Lynch wrote:
> Maybe I'm confused about something, but I'm able to use the vdso fine
> with an armhf userspace:

On my Dove CuBox, I have both armel and armhf binaries.  All armel stuff
lives in /armel (the machine used to run ubuntu 12.04 armel but now runs
ubuntu 12.04 armhf.)

root at cubox:~# LD_TRACE_LOADED_OBJECTS=1 /armel/lib/arm-linux-gnueabi/ld-linux.so.3 --library-path /lib/arm-linux-gnueabihf/ /armel/bin/cat
root at cubox:~# strace env LD_TRACE_LOADED_OBJECTS=1 /armel/lib/arm-linux-gnueabi/ld-linux.so.3 --library-path /lib/arm-linux-gnueabihf/ /armel/bin/cat
...
open("/lib/arm-linux-gnueabihf/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\355p\1\0004\0\0\0"..., 512) = 512
lseek(3, 888764, SEEK_SET)              = 888764
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1360) = 1360
lseek(3, 888324, SEEK_SET)              = 888324
read(3, "A4\0\0\0aeabi\0\1*\0\0\0\0057-A\0\6\n\7A\10\1\t\2\n\4\22"..., 53) = 53
exit_group(1)                           = ?

So there we have an armel dynamic linker with an armel binary encountering
an armhf library and silently failing.  Now let's try it the other way
around:

root at cubox:~# strace env LD_TRACE_LOADED_OBJECTS=1 /lib/arm-linux-gnueabihf/ld-linux-armhf.so.3 --library-path /armel/lib/arm-linux-gnueabi/ /bin/cat
...
open("/armel/lib/arm-linux-gnueabi/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\355p\1\0004\0\0\0"..., 512) = 512
lseek(3, 880572, SEEK_SET)              = 880572
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1360) = 1360
lseek(3, 880132, SEEK_SET)              = 880132
read(3, "A2\0\0\0aeabi\0\1(\0\0\0\0057-A\0\6\n\7A\10\1\t\2\n\4\22"..., 51) = 51
exit_group(1)                           = ?

The linker again silently throws its toys out the pram.

To prove that it's a working environment:

root at cubox:~# strace env LD_TRACE_LOADED_OBJECTS=1 /armel/lib/arm-linux-gnueabi/ld-linux.so.3 --library-path /armel/lib/arm-linux-gnueabi/ /armel/bin/cat
open("/armel/lib/arm-linux-gnueabi/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\355p\1\0004\0\0\0"..., 512) = 512
lseek(3, 880572, SEEK_SET)              = 880572
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1360) = 1360
lseek(3, 880132, SEEK_SET)              = 880132
read(3, "A2\0\0\0aeabi\0\1(\0\0\0\0057-A\0\6\n\7A\10\1\t\2\n\4\22"..., 51) = 51
fstat64(3, {st_mode=S_IFREG|0755, st_size=881932, ...}) = 0
...
set_tls(0xb6e544c0, 0xb6e54b98, 0xb6f59048, 0xb6e544c0, 0xb6f374f0) = 0
writev(1, [{"\t", 1}, {"libc.so.6", 9}, {" => ", 4}, {"/armel/lib/arm-linux-gnueabi/lib"..., 38}, {" (0x", 4}, {"b6e55000", 8}, {")\n", 2}], 7  libc.so.6 => /armel/lib/arm-linux-gnueabi/libc.so.6 (0xb6e55000)
) = 66
writev(1, [{"\t", 1}, {"/lib/ld-linux.so.3", 18}, {" => ", 4}, {"/armel/lib/arm-linux-gnueabi/ld-"..., 42}, {" (0x", 4}, {"b6f3a000", 8}, {")\n", 2}], 7
/lib/ld-linux.so.3 => /armel/lib/arm-linux-gnueabi/ld-linux.so.3 (0xb6f3a000)
) = 79
exit_group(0)                           = ?

and of course the armhf environment works because that's the one the
machine currently boots.

The obvious question therefore is, if the dynamic linker throws its toys
out if it encounters a wrong-float-ABI library during a standard library
search, why would it _not_ throw its toys out on dlsym.  The difference
in behaviour would to me seem to be a bug - both should behave the same,
though of course not throwing its toys out, but instead producing an error
_or_ accepting the difference.  Given that it's an ABI difference,
rejecting the library is the only sane approach.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
