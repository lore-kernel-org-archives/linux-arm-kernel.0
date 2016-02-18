From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 19 Feb 2016 01:35:06 +0300
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <56AC38F1.2030608@huawei.com>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <56AB3805.1040308@huawei.com> <20160129170929.GA3543@yury-N73SV>
 <56AC38F1.2030608@huawei.com>
Message-ID: <20160218223506.GA7816@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 30, 2016 at 12:15:45PM +0800, Zhangjian (Bamvor) wrote:
> Hi, Yury
> 
> On 1:09 2016/1/30, Yury Norov wrote:
> >On Fri, Jan 29, 2016 at 05:59:33PM +0800, Zhangjian (Bamvor) wrote:
> >>Hi,
> >>
> >>On 1:22 2016/1/15, Yury Norov wrote:
> >>>This is still RFC because we have no glibc yet, that correspnds new ABI
> >>>introduced here. And so we cannot run tests. LP64 and AARCH32 tests show
> >>>no regression though.
> >>Hi,
> >>
> >>Glad to see this version. I hope I could test it. Where could I find the
> >>corresponding glibc? I could not find it in
> >>http://github.com/norov/glibc.git. Or is there a plan to do it?
> >>
> >>Besides compat wrappers discussed in these series, is there any other
> >>blockers for upstream? I would suppose everyone is intestested in the
> >>result of LTP...
> >>
> >>Regards
> >>
> >>Bamvor
> >>
> >
> >Hi, Bamvor,
> >
> >Just to order all commits, I created new ILP32 branch at [1], that
> >based on 4.4 kernel + [2] + [3]. There's no new glibc suitable for
> >rfc5. But I started with it, and I hope there will be progress soon.
> Cool:)
> >
> >You cannot run LTP as there are some syscalls that are called during
> >dynamic loading that fail, but you can try to build your test statically
> >agaginst current glibc, and there's a big chance it will work.
> >I have a set of 'hello-worlds' working that way.
> Currrently, I got 300+ in ltplite with you glibc[1]. I will try static link
> later.
> >
> >If you have some specific test that you cannot run, you can send it to
> >me, and I will take a look on it.
> Sure, I am reading the test results. Hope we could fix these failure
> together.
> 
> Regards
> 
> Bamvor
> 
> [1] https://github.com/norov/glibc/tree/thunderx-ilp32-32time_toff_t
> >
> >Yury
> >
> >[1] https://github.com/norov/linux/tree/rfc5
> >[2] http://permalink.gmane.org/gmane.linux.kernel/2116021
> >[3] http://comments.gmane.org/gmane.linux.kernel/2134747
> >
> >>>
> >>>  v3: https://lkml.org/lkml/2014/9/3/704
> >>>  v4: https://lkml.org/lkml/2015/4/13/691
> >>>  v5: https://lkml.org/lkml/2015/9/29/911
> >>>

Hi Bamvor, everybody,

I have new glibc that follows new ABI:
https://github.com/norov/glibc/tree/new-api

It's very draft and dirty, but you can try it with RFC5.
My fail list for ltplite looks like this:
pipeio_4                       FAIL       11   
abort01                        FAIL       2    
clone02                        FAIL       4    
kill10                         FAIL       2    
kill11                         FAIL       2    
lstat01A                       FAIL       1    
lstat02                        FAIL       1    
mmap16                         FAIL       6    
nanosleep03                    FAIL       1    
nftw01                         FAIL       1    
nftw6401                       FAIL       1    
open12                         FAIL       2    
pathconf01                     FAIL       1    
pipe07                         FAIL       2    
profil01                       FAIL       11   
readdir01                      FAIL       1    
readlink01A                    FAIL       1    
rename11                       FAIL       2    
rmdir02                        FAIL       2    
sigaltstack01                  FAIL       1    
sigaltstack02                  FAIL       1    
stat03                         FAIL       1    
stat04                         FAIL       1    
stat06                         FAIL       1    
umount2_01                     FAIL       2    
umount2_02                     FAIL       2    
umount2_03                     FAIL       2    
utime06                        FAIL       2    
writev01                       FAIL       1    
mtest06                        FAIL       11   
rwtest01                       FAIL       2    
rwtest02                       FAIL       2    
rwtest03                       FAIL       2    
rwtest04                       FAIL       2    
rwtest05                       FAIL       2

Float tests are exluded, but also fail. Totally, ~40 of 787 tests
fail.

Yury
