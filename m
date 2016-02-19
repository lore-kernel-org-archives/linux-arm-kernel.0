From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 19 Feb 2016 15:59:59 +0300
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <208897488.c0hkBy2G1S@wuerfel>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <56AC38F1.2030608@huawei.com> <20160218223506.GA7816@yury-N73SV>
 <208897488.c0hkBy2G1S@wuerfel>
Message-ID: <20160219125959.GA8675@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 09:23:35AM +0100, Arnd Bergmann wrote:
> On Friday 19 February 2016 01:35:06 Yury Norov wrote:
> > 
> > Hi Bamvor, everybody,
> > 
> > I have new glibc that follows new ABI:
> > https://github.com/norov/glibc/tree/new-api
> 
> Ah, very good!
> 
> > It's very draft and dirty, but you can try it with RFC5.
> > My fail list for ltplite looks like this:
> > pipeio_4                       FAIL       11   
> > abort01                        FAIL       2    
> > clone02                        FAIL       4    
> > kill10                         FAIL       2    
> > kill11                         FAIL       2    
> > lstat01A                       FAIL       1    
> > lstat02                        FAIL       1    
> > mmap16                         FAIL       6    
> > nanosleep03                    FAIL       1    
> > nftw01                         FAIL       1    
> > nftw6401                       FAIL       1    
> > open12                         FAIL       2    
> > pathconf01                     FAIL       1    
> > pipe07                         FAIL       2    
> > profil01                       FAIL       11   
> > readdir01                      FAIL       1    
> > readlink01A                    FAIL       1    
> > rename11                       FAIL       2    
> > rmdir02                        FAIL       2    
> > sigaltstack01                  FAIL       1    
> > sigaltstack02                  FAIL       1    
> > stat03                         FAIL       1    
> > stat04                         FAIL       1    
> > stat06                         FAIL       1    
> > umount2_01                     FAIL       2    
> > umount2_02                     FAIL       2    
> > umount2_03                     FAIL       2    
> > utime06                        FAIL       2    
> > writev01                       FAIL       1    
> > mtest06                        FAIL       11   
> > rwtest01                       FAIL       2    
> > rwtest02                       FAIL       2    
> > rwtest03                       FAIL       2    
> > rwtest04                       FAIL       2    
> > rwtest05                       FAIL       2
> 
> I have no idea whether this is good news or bad news ;-)
> 
> In https://github.com/norov/glibc/commit/351b8728fdb365bd4852ac113601ddf38153fdfc
> I see that you are passing __IPC_64, I thought we had already resolved
> that in the kernel. We might need to go back to this.
> 

I'm still on 4.4 kernel. So I need it. I'll drop __IPC_64 if unneeded on
rebase. Usually I rebase on rc5 or rc6.

> In https://github.com/norov/glibc/commit/5d4290435e428267171ece871539b76e1d079d11
> you are defining a struct __kernel_stat64 in the glibc. Is this the expected
> way to do it? I would have thought you'd get the definition from the kernel
> headers.
>  
> 	Arnd
> 

Almost all ports define its own struct kernel_stat / kernel_stat64.
in "kernel_header.h" See mips, spark, alpha, i386... Some also define
function xstat_conv or similar. With all that defined, it's expected
that one of generic xstat wrappers will work properly. I tried all,
and noone got working, so I wrote this hack to make it work somehow. 


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
