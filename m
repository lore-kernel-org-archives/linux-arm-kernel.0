From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 1 Feb 2016 14:49:36 +0800
Subject: MTK mt8173-evb: mainline unstable, and big-endian boot failures
In-Reply-To: <7hy4b8gc7q.fsf@baylibre.com>
References: <CAOi56cVDbkAJEDWy3+DV63a=UuD7nqpUu8X7e-OjtWM-4dj_-w@mail.gmail.com>
 <7hsi1ilczm.fsf@baylibre.com>
 <CAF-23O3ps0Wt_UCmJbArpc5iJJryJKA0k_2qAyNb7op8O=UnAg@mail.gmail.com>
 <1453964180.26397.8.camel@mtksdaap41> <7hy4b8gc7q.fsf@baylibre.com>
Message-ID: <1454309376.11974.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Fri, 2016-01-29 at 16:09 -0800, Kevin Hilman wrote:
> Hi Eddie, Freedom,
> 
> Eddie Huang <eddie.huang@mediatek.com> writes:
> 
> > On Thu, 2016-01-28 at 13:41 +0800, Koan-Sin Tan wrote:
> 
> [...]
> 
> >>    Thanks for the information. I'll try to reproduce it. The problem
> >> is that I have been using 4.5-rc1 based kernel for several days, but
> >> didn't run into such problem. Can tell me which version of firmware
> >> you are using? 
> >
> > I use firmware [0] to run kernel v4.5-rc1 on my MT8173-evb, both branch
> > v20150716 (psci-0.2 atf) and v20150902 (psci-1.0 atf) can't reproduce
> > this problem.
> 
> I'm running firmware from the master branch of the same repo.  The top
> commit is the PSCI 1.0 support.
> 
> It's not exactly easy to reproduce the problem, and you it seems you
> will not likely see it unless you have lots of input on the serial
> console.  Just booting to a shell may not reproduce the problem, you may
> need to try to copy/paste a bunch of commands in order to see characters
> being dropped.
> 
> For example, I'm able to reproduce pretty easily by just booting to a
> busybox ramdisk[1], and then copy/pasting a bunch of commands[2] to the
> shell prompt.
> 
> What I noticed is that sometimes it works, and sometimes it doesn't.
> you can tell because you don't get back to a shell problem, but rather
> to the shell's ">" prompt telling you it's still waiting for input to
> finish.
> 
> Ususally it fails for me within 4-5 times of copy/pasting these lines.
> 
> If I add nohlt to the command-line I can repeatedly copy/paste and there
> is never any loss of characters.
> 
> Could you please try this experiment on v4.5-rc1 and let me know if it's
> working for you?
> 
> Thanks
> 
> Kevin
> 
> [1] http://storage.kernelci.org/images/rootfs/buildroot/arm64/rootfs.cpio.gz
> [2]
> dmesg -n 1
> DMESG=$(readlink -f /bin/dmesg)
> [[ $DMESG = "/bin/dmesg" ]] && dmesg -l warn | awk '{ print "[WARN] " $0}'
> [[ $DMESG = "/bin/dmesg" ]] && dmesg -l err | awk '{ print "[ERR] " $0}'
> [[ $DMESG = "/bin/dmesg" ]] && dmesg -l alert | awk '{ print "[ERR] " $0}'
> [[ -e /var/log/messages ]] && grep kern.warn /var/log/messages | awk '{print "[WARN] " $0 }'
> [[ -e /var/log/messages ]] && grep kern.err /var/log/messages | awk '{print "[ERR] " $0 }'
> [[ -e /var/log/messages ]] && grep kern.alert /var/log/messages | awk '{print "[ERR] " $0 }'
> echo "hello, world"
> 

Thanks your patience to provide detail steps, we can reproduce this
problem now. It seems something wrong in ATF, we still investigate how
to fix it. We will provide you new ATF firmware once we have solution

Regards,
Eddie
