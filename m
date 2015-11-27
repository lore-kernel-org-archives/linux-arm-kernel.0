From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Nov 2015 13:27:23 +0000
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
In-Reply-To: <20151126090739.GD14190@pali>
References: <20150713131902.GH26485@atomide.com> <20151123144545.GD24147@pali>
 <20151125181644.GI2517@atomide.com> <17134653.86P3dFyQKK@wuerfel>
 <20151125210310.GT2517@atomide.com> <56568849.5080103@gmail.com>
 <20151126090739.GD14190@pali>
Message-ID: <20151127132722.GA30871@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 10:07:39AM +0100, Pali Roh?r wrote:
> On Wednesday 25 November 2015 20:19:21 Frank Rowand wrote:
> > > Or populate /proc/atags only for the ones that need it from machine
> > > specific init_early?
> > 
> > This is circling back to the first comment from Russell King where
> > he suggested a legacy file for the N900 which calls save_atags():
> > 
> >     Are the ATAGs at a fixed address on the N900?  Can that be handled in
> >     some kind of legacy file for the N900 which calls save_atags() on it, so
> >     we don't end up introducing yet more stuff that we have to maintain into
> >     the distant future?  If not, what about copying a known working atag
> >     structure into a legacy file for the N900?
> > 
> > It seems to me that patches 1, 2, 4, and 5 could be replaced by this
> > approach.
> 
> Hi Frank, in this case I will ask my question again: It is possible to
> read atags from that legacy file. And if yes how? I was not thinking
> about this approach because somebody in past wrote that this is not
> possible...

It is possible to redirect any program to open any other file.  You can
do it via a LD preload, and intercepting the open(), and possibly the
read() calls if you want to do something more fancy.  The down-side is
that you have to arrange for the preloaded object to be used by the
linker, and the additional overhead it places on the intercepted
functions.

Eg,

openatags.c:

#define open libc_open
#include <fcntl.h>
#undef open
#include <string.h>

int open(const char *pathname, int flags, mode_t mode)
{
        static int (*old_open)(const char *pathname, int flags, mode_t mode);

        if (strcmp(pathname, "/proc/atags") == 0)
		pathname = "/tmp/my-atags";

        if (!old_open)
                old_open = dlsym(RTLD_NEXT, "open");

        return old_open(pathname, flags, mode);
}

Build the above (untested) with:
gcc -O2 -o openatags.o -c openatags.c
gcc -shared -o openatags.so openatags.o -ldl

Now, when running one of these programs, you can test it with:
LD_PRELOAD=openatags.so /name/of/program

You could also list the full pathname to openatags.so in /etc/ld.so.preload,
but test it first, because it will always be used by the linker in that
case, and you wouldn't want normal commands to misbehave.

Note that putting it in /etc/ld.so.preload will also have the effect that
cat /proc/atags will also get redirected to /tmp/my-atags too.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
