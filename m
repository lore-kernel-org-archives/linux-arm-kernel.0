From: lkp@intel.com (kbuild test robot)
Date: Sun, 26 Mar 2017 16:45:33 +0800
Subject: [PATCH v3 7/7] vga: Optimise console scrolling
In-Reply-To: <20170324161318.18718-8-willy@infradead.org>
Message-ID: <201703261615.IpHMoe8K%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthew,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc3 next-20170324]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox/Add-memsetN-functions/20170326-140108
config: sparc-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc 

All error/warnings (new ones prefixed by >>):

   In file included from include/video/vga.h:22:0,
                    from include/linux/vgaarb.h:34,
                    from drivers/gpu//drm/amd/amdgpu/amdgpu_device.c:35:
   arch/sparc/include/asm/vga.h: In function 'scr_memsetw':
>> arch/sparc/include/asm/vga.h:39:11: error: 's' undeclared (first use in this function)
     memset16(s, cpu_to_le16(v), n / 2);
              ^
   arch/sparc/include/asm/vga.h:39:11: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from include/video/vga.h:22:0,
                    from include/linux/vgaarb.h:34,
                    from drivers/gpu//drm/nouveau/nouveau_vga.c:1:
   arch/sparc/include/asm/vga.h: In function 'scr_memsetw':
>> arch/sparc/include/asm/vga.h:39:2: error: implicit declaration of function 'memset16' [-Werror=implicit-function-declaration]
     memset16(s, cpu_to_le16(v), n / 2);
     ^~~~~~~~
>> arch/sparc/include/asm/vga.h:39:11: error: 's' undeclared (first use in this function)
     memset16(s, cpu_to_le16(v), n / 2);
              ^
   arch/sparc/include/asm/vga.h:39:11: note: each undeclared identifier is reported only once for each function it appears in
   arch/sparc/include/asm/vga.h: In function 'scr_memcpyw':
>> arch/sparc/include/asm/vga.h:46:2: error: implicit declaration of function 'memcpy' [-Werror=implicit-function-declaration]
     memcpy(d, s, n);
     ^~~~~~
>> arch/sparc/include/asm/vga.h:46:2: warning: incompatible implicit declaration of built-in function 'memcpy'
   arch/sparc/include/asm/vga.h:46:2: note: include '<string.h>' or provide a declaration of 'memcpy'
   arch/sparc/include/asm/vga.h: In function 'scr_memmovew':
>> arch/sparc/include/asm/vga.h:53:2: error: implicit declaration of function 'memmove' [-Werror=implicit-function-declaration]
     memmove(d, s, n);
     ^~~~~~~
>> arch/sparc/include/asm/vga.h:53:2: warning: incompatible implicit declaration of built-in function 'memmove'
   arch/sparc/include/asm/vga.h:53:2: note: include '<string.h>' or provide a declaration of 'memmove'
   In file included from include/uapi/linux/uuid.h:21:0,
                    from include/linux/uuid.h:19,
                    from include/linux/mod_devicetable.h:12,
                    from include/linux/i2c.h:29,
                    from include/uapi/linux/fb.h:5,
                    from include/linux/fb.h:5,
                    from include/linux/vga_switcheroo.h:34,
                    from drivers/gpu//drm/nouveau/nouveau_vga.c:2:
   include/linux/string.h: At top level:
>> include/linux/string.h:104:14: error: conflicting types for 'memset16'
    extern void *memset16(uint16_t *, uint16_t, __kernel_size_t);
                 ^~~~~~~~
   In file included from include/video/vga.h:22:0,
                    from include/linux/vgaarb.h:34,
                    from drivers/gpu//drm/nouveau/nouveau_vga.c:1:
   arch/sparc/include/asm/vga.h:39:2: note: previous implicit declaration of 'memset16' was here
     memset16(s, cpu_to_le16(v), n / 2);
     ^~~~~~~~
   cc1: some warnings being treated as errors

vim +/s +39 arch/sparc/include/asm/vga.h

    33	}
    34	
    35	static inline void scr_memsetw(u16 *p, u16 v, unsigned int n)
    36	{
    37		BUG_ON((long) p >= 0);
    38	
  > 39		memset16(s, cpu_to_le16(v), n / 2);
    40	}
    41	
    42	static inline void scr_memcpyw(u16 *d, u16 *s, unsigned int n)
    43	{
    44		BUG_ON((long) d >= 0);
    45	
  > 46		memcpy(d, s, n);
    47	}
    48	
    49	static inline void scr_memmovew(u16 *d, u16 *s, unsigned int n)
    50	{
    51		BUG_ON((long) d >= 0);
    52	
  > 53		memmove(d, s, n);
    54	}
    55	
    56	#define VGA_MAP_MEM(x,s) (x)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49779 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170326/b8e77df5/attachment-0001.gz>
