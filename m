From: ybzhao1989@gmail.com (Zhao Yibin)
Date: Tue, 16 May 2017 12:06:02 +0800
Subject: PROBLEM: ARM Cache policy on single armv7 processor lead to low DRAM
 performance
Message-ID: <CAOEkoLwq1fdVuhkm_Z4Lf1BL0XxLyumSxLF7gDPyK_NkzUdVgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, ARM maintainers,

We met some DDR performance issue caused by armv7 cache policy, hope
you can help.
On a single armv7(Cortex-A7) processor system, the arm linux kernel,
without CONFIG_SMP, the cache policy is set to write-back no-allocate,
which lead to very low DRAM speed,
around 7MB/s for write, 28MB/s for read.
If enable CONFIG_SMP and CONFIG_SMP_ON_UP, then the cache policy is
changed to write-back read-write-allocate, and the DRAM speed is
improved a lot, around 120MB/s for write, 160MB/s for read.

The cache property set in arch/arm/mm/proc-v7-2level.S, shows the difference:
/* PTWs cacheable, inner WB not shareable, outer WB not shareable */
#define TTB_FLAGS_UP    TTB_IRGN_WB|TTB_RGN_OC_WB
#define PMD_FLAGS_UP    PMD_SECT_WB

/* PTWs cacheable, inner WBWA shareable, outer WBWA not shareable */
#define TTB_FLAGS_SMP    TTB_IRGN_WBWA|TTB_S|TTB_NOS|TTB_RGN_OC_WBWA
#define PMD_FLAGS_SMP    PMD_SECT_WBWA|PMD_SECT_S


Is this a bug, or the desired behavior? and we have to enable SMP on
single processor system?

2. Test method:
dd if=/dev/zero of=/dev/shm/abc bs=10M count=5
dd if=/dev/shm/abc of=/dev/null bs=10M count=5

3. ARM Linux kernel version:
Linux version 4.4.52+ (xxx at yyy) (gcc version 5.3.0 (Timesys 20160523)
) #8 SMP PREEMPT Tue May 16 10:59:10 CST 2017

4. sh$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux build1 3.16.0-4-amd64 #1 SMP Debian 3.16.39-1 (2016-12-30)
x86_64 GNU/Linux

GNU C                   4.9.2
GNU Make                3.81
Binutils                2.25
Util-linux              2.25.2
Mount                   2.25.2
Module-init-tools       18
E2fsprogs               1.42.12
Linux C Library         2.19
Dynamic linker (ldd)    2.23
Procps                  3.3.9
Net-tools               1.60
Kbd                     1.15.5
Console-tools           1.15.5
Sh-utils                8.23
Udev                    215
Wireless-tools          30
Modules Loaded          ablk_helper aesni_intel aes_x86_64 ahci
asus_wmi auth_rpcgss autofs4 button cfg80211 coretemp
cpufreq_conservative cpufreq_powersave cpufreq_stats cpufreq_userspace
crc16 crc32c_intel crc32_pclmul crc_t10dif crct10dif_common
crct10dif_generic crct10dif_pclmul cryptd dm_mod drm drm_kms_helper
e1000e eeepc_wmi ehci_hcd ehci_pci evdev ext4 fscache fuse gf128mul
glue_helper i2c_algo_bit i2c_core i2c_i801 intel_powerclamp intel_rapl
iTCO_vendor_support iTCO_wdt jbd2 kvm kvm_intel libahci libata lockd
lpc_ich lrw mbcache mei mei_me mfd_core mxm_wmi nfs nfs_acl nfsd
nouveau oid_registry pcspkr pps_core processor psmouse ptp rfkill
scsi_mod sd_mod serio_raw sg shpchp snd snd_hda_codec
snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_codec_realtek
snd_hda_controller snd_hda_intel snd_hwdep snd_pcm snd_timer soundcore
sparse_keymap sunrpc thermal_sys tpm tpm_infineon tpm_tis ttm
usb_common usbcore video wmi x86_pkg_temp_thermal xhci_hcd


Thanks
Bob
