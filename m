From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 1 Aug 2016 13:37:26 +0900
Subject: [PATCH v23 0/9] arm64: add kdump support
In-Reply-To: <20160729171300.GA478@localhost.localdomain>
References: <20160726075659.2290-1-takahiro.akashi@linaro.org>
 <20160726080925.GA2363@linaro.org>
 <CAB=otbTODnOwFiLZT7bm1_MLyORQ1cx-gaeg7bm+bReaMRhYwg@mail.gmail.com>
 <20160729171300.GA478@localhost.localdomain>
Message-ID: <20160801043725.GC7995@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pratyush,

On Fri, Jul 29, 2016 at 10:43:00PM +0530, Pratyush Anand wrote:
> Hi Ruslan,
> 
> On 29/07/2016:07:26:03 PM, Ruslan Bilovol wrote:
> > Hi,
> > 
> > On Tue, Jul 26, 2016 at 11:09 AM, AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> > > On Tue, Jul 26, 2016 at 04:56:51PM +0900, AKASHI Takahiro wrote:
> > >> This patch series adds kdump support on arm64.
> > >>
> > >> To load a crash-dump kernel to the systems, a series of patches to
> > >> kexec-tools, which have not yet been merged upstream, are needed.
> > >> Please pick Geoff's kexec patches [1] and my kdump patches [2].
> > >>
> > >> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
> > >>   - crash utility (coming v7.1.6 or later) [3]
> > >>     (Necessary patches have already been queued in the master.)
> > >>
> > >> [1]  http://lists.infradead.org/pipermail/kexec/2016-July/016532.html
> > >> [2]  TBD
> > >
> > > See my kexec-tools patches in:
> > > http://lists.infradead.org/pipermail/kexec/2016-July/016642.html
> > 
> > I tired this patch series with mentioned Geoff's kexec patches and
> > your kdump patches, but unfortunately it doesn't work for me.
> > 
> > While I can successfully load and kexec the kernel ('kexec --load' +
> > 'kexec -e'), same combination of kernel+ramdisk+dtb doesn't boot
> > if I do kdump combination ('kexec -p' + sysrq crash), there is no
> > any output after sysrq crash trace.
> > Unfortunately I don't have any debugger here for deep investigation
> > of this issue.
> 
> Which type of image do you have? I did face issue with binary image which I
> fixed in my branch, while elf would work fine for kdump as well.

Can you describe in more details, please?
I don't see any problems with either vmlinux or image
in my environment.

Thanks,
-Takahiro AKASHI

> > 
> > Also for some reason in case of 'load and kexec the kernel' it
> > takes 1-2 minutes to start booting after I do kexec -e, need to
> > investigate it further.
> 
> Because, D-cache is disabled.
> 
> > 
> > Which hardware do you use for validating your patches?
> > 
> > Also, could you please share exact commands you use for
> > kdump validation?
> 
> Well, I have some patches for D-cache enabling, which will be sent for review
> after these set of kexec and kdump patches are merged.
> 
> Meanwhile, you can use them and give your feedback. They are here:
> https://github.com/pratyushanand/kexec-tools.git : upstream_arm64_devel
> 
> I use following command with my test branch. You can ignore --port and
> --port-lsr in your setup. You may use --enable-dcache and  let me know if it
> works for you and improves execution speed. You may need to change vmlinux and
> inird name as per your setup.
> 
> for kexec test:
> kexec -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname -r`.img
> --reuse-cmdline --enable-dcache --port=0x1c020000
> --port-lsr=0x1c020014,0x60;kexec -e
> 
> for kdump test:
> kexec -p /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname -r`kdump.img
> --reuse-cmdline --enable-dcache --port=0x1c020000 --port-lsr=0x1c020014,0x60
> --append="irqpoll maxcpus=1 reset_devices"; echo c > /proc/sysrq-trigger
> 
> ~Pratyush
