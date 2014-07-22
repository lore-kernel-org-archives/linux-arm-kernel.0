From: achandran@mvista.com (Arun Chandran)
Date: Tue, 22 Jul 2014 15:14:12 +0530
Subject: Kexec on arm64
In-Reply-To: <1405551861.7262.26.camel@smoke>
References: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
 <1405443898.22585.7.camel@smoke>
 <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
 <1405551861.7262.26.camel@smoke>
Message-ID: <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 4:34 AM, Geoff Levand <geoff@infradead.org> wrote:
> Hi Feng,
>
> On Wed, 2014-07-16 at 10:57 -0700, Feng Kan wrote:
>> Just following up on the conversation. The cpu return address of 0 should work
>> in your case. Since thats the _start of the bootloader, it will run
>> some core init
>> code and then put the core back in wfe.
>
> OK, I fixed up my code so that zero is valid cpu return address.  Arun,
> could you try my latest I pushed out today?
>
Hi Geoff,

Sorry for the late reply I was away.

Yes I tried the new code.
My dts file has the below change.

################
diff --git a/arch/arm64/boot/dts/apm-storm.dtsi
b/arch/arm64/boot/dts/apm-storm.dtsi
index e0bf91d..b64e549 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -24,64 +24,64 @@
                        compatible = "apm,potenza", "arm,armv8";
                        reg = <0x0 0x000>;
                        enable-method = "spin-table";
-                       cpu-release-addr = <0x1 0x0000fff8>;
-                       cpu-return-addr = <0x0 0x0> /* Updated by bootloader */
+                       cpu-release-addr = <0x40 0x0000fff8>;
+                       cpu-return-addr = <0x0 0x0>; /* Updated by bootloader */
                };
#################
All other cpu nodes have similar change.

1) Loading  ( I don't change commandline and dtb; assuming kexec will
reuse whatever
the booted kernel has as commandline and dtb)

# kexec -l vmlinux.strip
kexec version: 14.07.17.12.17-gb6cccb4
Modified cmdline: root=/dev/nfs
Unable to find /proc/device-tree//chosen/linux,stdout-path, printing
from purgatory is diabled
Modified cmdline: root=/dev/nfs
Unable to find /proc/device-tree//chosen/linux,stdout-path, printing
from purgatory is diabled
machine_kexec_prepare:508:
  kexec image info:
    type:        0
    start:       4000080004
    head:        0
    nr_segments: 2
      segment[0]: 0000004000080000 - 000000400088c000, 80c000h bytes, 2060 pages
kexec_is_dtb:115: magic: 4d5a0091 : 91005a4d : no
      segment[1]: 00000040008a0000 - 00000040008a3000, 3000h bytes, 3 pages
kexec_is_dtb:115: magic: d00dfeed : edfe0dd0 : yes
kexec_boot_info_init:384: cpu_count: 8
kexec_cpu_info_init:352: cpu-0: hwid-0, 'spin-table', cpu-release-addr
400000fff8, cpu-return-addr 0
kexec_cpu_info_init:352: cpu-1: hwid-1, 'spin-table', cpu-release-addr
400000fff8, cpu-return-addr 0
kexec_cpu_info_init:352: cpu-2: hwid-100, 'spin-table',
cpu-release-addr 400000fff8, cpu-return-addr 0
kexec_cpu_info_init:352: cpu-3: hwid-101, 'spin-table',
cpu-release-addr 400000fff8, cpu-return-addr 0
kexec_cpu_info_init:352: cpu-4: hwid-200, 'spin-table',
cpu-release-addr 400000fff8, cpu-return-addr 0
kexec_cpu_info_init:352: cpu-5: hwid-201, 'spin-table',
cpu-release-addr 400000fff8, cpu-return-addr 0
kexec_cpu_info_init:352: cpu-6: hwid-300, 'spin-table',
cpu-release-addr 400000fff8, cpu-return-addr 0
kexec_cpu_info_init:352: cpu-7: hwid-301, 'spin-table',
cpu-release-addr 400000fff8, cpu-return-addr 0
kexec_is_dtb:115: magic: 4d5a0091 : 91005a4d : no
kexec_is_dtb:115: magic: d00dfeed : edfe0dd0 : yes
kexec_boot_info_init:384: cpu_count: 8
kexec_cpu_info_init:352: cpu-0: hwid-0, 'spin-table', cpu-release-addr
400000fff8, cpu-return-addr 0
kexec_cpu_info_init:352: cpu-1: hwid-1, 'spin-table', cpu-release-addr
400000fff8, cpu-return-addr 0
kexec_cpu_info_init:352: cpu-2: hwid-100, 'spin-table',
cpu-release-addr 400000fff8, cpu-return-addr 0
kexec_cpu_info_init:352: cpu-3: hwid-101, 'spin-table',
cpu-release-addr 400000fff8, cpu-return-addr 0
kexec_cpu_info_init:352: cpu-4: hwid-200, 'spin-table',
cpu-release-addr 400000fff8, cpu-return-addr 0
kexec_cpu_info_init:352: cpu-5: hwid-201, 'spin-table',
cpu-release-addr 400000fff8, cpu-return-addr 0
kexec_cpu_info_init:352: cpu-6: hwid-300, 'spin-table',
cpu-release-addr 400000fff8, cpu-return-addr 0
kexec_cpu_info_init:352: cpu-7: hwid-301, 'spin-table',
cpu-release-addr 400000fff8, cpu-return-addr 0
kexec_cpu_check:440: hwid-0 OK
kexec_cpu_check:440: hwid-1 OK
kexec_cpu_check:440: hwid-100 OK
kexec_cpu_check:440: hwid-101 OK
kexec_cpu_check:440: hwid-200 OK
kexec_cpu_check:440: hwid-201 OK
kexec_cpu_check:440: hwid-300 OK
kexec_cpu_check:440: hwid-301 OK


2) Rebooting
#########################
# kexec -e
kexec version: 1kvm: exiting hardware virtualization
4.07.17.12.17-gbStarting new kernel
6cccb4
 Ump_spin_tanblaeb_lcpeu_d ite:127: oi dh:a n7d,l holding count: 0e
 kernel NULL pointer dereference at virtual address 00000291
smp_spin_Itnaibtlei_cpaul_diie:12z7:i nigd :c 3g,r oholding couunpt :s 0u
bsys cpu
smpL_isnpuixn _table_cpu_diev:e1r2s7i:o ni d: 6, hol3d.i1n6g. 0c-orucnt: 0
4+ (arun at arun-OptiPlex-9010) (gcc version 4.9.1 20140505 (prerelease)
(crosstool-NG linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05) )
#25 SMP smp_sPpin_tablReE_EcMpPuT_ dTie:127: iude:  J5u, hlo ld2ing
coun2:
37:03 IST 2014
smp_Cspin_tPabUl:e _AcApruc_die:127: id: h46,4  hPorldiong count:c e0s
 or [500f0000] revision 0
smp_speifni_:t aGbeltet_cpu_die:i1n2g7 : ipd:a 2, holdinrga mceount:t e0
rs from FDT:
smep_fsip:i nC_atable_cpu_dien:'1t27: i df: 1i, holdinngd  cSoyusntt:e 0
m Table in device tree!
macchimne_kexaec:: 572C: smp_pMrAo:c efsasiorl_ied = 0
d to reserve 16 MiB
dachine_kexecO:n5 7n4o:
 e 0 totalpages: 4194304
a k e xec image inNfoor:m
 l zone: 57344 pages used for memmap
    type:        0
z   sta r tN:o     r  m4a0000800l04
 one: 4194304 pages, LIFO batch:31
    head:   P E R   43Cea9bPf002
U: Embedded 11 pages/cpu @ffffffc3fff7d000 s13120 r8192 d23744 u45056
    nrp_cspeug-maelnltosc: 2
: s13120 r8192 d23744 u45056 alloc=11*4096
   p c p usegment-[a0l]l:o c0:0 0[0000400]00 800 000[ -0 ]0000004000
881c 0[000],  280c000h bytes,  [200]6 0 3pages
 [0] 4 [0] 5 [0] 6 [0] 7
eexBeuc_is_dtb:1i1l5:t  m1a gizc: 0 : 0 : noon
 lists in Zone order, mobility grouping on.  Total pages: 4136960
/  K e r segment[1]: n0e0l0 00c0o400m08a0000 m-a n0d00
00040l008ai30n00e,:  3r000ho obty=tes, 3/ dpeagesv
 nfs rw nfsroot=10.162.103.228:/nfs_root/dora_june_6/apm-image-minimal-mustangbe
ip=10.162.103.21:10.162.103.228:10.162.103.1:255.255.255.0:mustangk:eextehc_0is:_odtb:1f15f:
 pmaangic:i 0c =: 0 : 1no
console=ttyS0,115200 earlyprintk=uart8250-32bit,0x1c020000 debug
maxcpus=8 swiotlb=65536 log_buf_len=1M
8aclhinoeg_kex_ec:582: cobnturfo_ll_ecode_page:        nf:f f1ff0fbc4edb67ee8
 576
6achinee_akrelxyec: 58l4: reobogo tb_ucfo dfe_buffer_physr:e e :0
000010435eaffb00007
 (92%)
macPhine_IkDexec:58 6h:a srehb otot_acode_bufferb:l e   e n t
rfifffffce3se:a f4f0b000
96 (order: 3, 32768 bytes)
macDhine_kexeecn:t5r88: ryel occate_neaw_ckheer nelh:a s     fffffhf
c0t0a0093b18
ble entries: 2097152 (order: 12, 16777216 bytes)
machineI_kneoxedc:5e90-: relocate_cnaecwh_ek ehransel_size: b8hh( 1t84)a bytes
ble entries: 1048576 (order: 11, 8388608 bytes)
machinMe_keemxoercy::5 913: kexec6_5d0t8b_6addr2:4 K
0/0100004600708a0000
77216K available (4360K kernel code, 299K rwdata, 1528K rodata, 6556K
init, 202K bss, 268592K reserved)
oacVhinei_kretxueacl: 595: kexec_kkeirmnaegle _mhead:     e m o r0y0
00l0043eaa9bf002y
 ut:
    vmalloc : 0xffffff8000000000 - 0xffffffbbffff0000   (245759 MB)
    vmemmap : 0xffffffbce0000000 - 0xffffffbcee000000   (   224 MB)
0  machine_ kmeoxdecu:l597:e kexecs_ k:i m0age_xsftarft:    f  f
f0f0b0f0f0c04000080004
 00000 - 0xffffffc000000000   (    64 MB)
    memory  : 0xffffffc000000000 - 0xffffffc400000000   ( 16384 MB)
      .init : 0xffffffc000642000 -machine_ke x0excf:f5f99:f
kexec_efntfrcy0_0d0ump:
ca9340   (  6557 kB)
      .text : 0xffffffc000080000 - 0xffffffc0006411c4   (  5893 kB)
f     .data : 0xffffffc000caa000 - 0xffffffc000cf4f28     (I
43ea9bf002 =  343ea9b0f000 (f0fffffc 3ekaB9)b
 000)
d D 40S0LU00B8:0 0H0W1 = a4000080000l i(gfnf=f6f4ffc,00008000 0O)r
######################

This doesn't seems to be working. Random behaviors are observed. Some
times it rebooted to u-boot
prompt. Sometimes kernel soft resets itself in an endless loop
(bootlog is repeating over and over again)

To debug what is happening I put a while(1) just before jumping into
kexec reboot code.

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 31cba91..8843623 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -85,6 +85,7 @@ void soft_restart(unsigned long addr)

        smp_secondary_shutdown();

+       while(1);
        /* Switch to the identity mapping */
        phys_reset = (phys_reset_t)virt_to_phys(cpu_reset);
        phys_reset(addr);

I break into target with BDI3000 now; and see the below output

TARGET#0>state
Core#0: halted 0xffffffc000085240 External Debug Request
Core#1: halted 0x0000004000080394 External Debug Request
Core#2: halted 0x0000004000080394 External Debug Request
Core#3: halted 0x0000004000080394 External Debug Request
Core#4: halted 0xffffffc0000802f8 External Debug Request
Core#5: halted 0x0000004000080394 External Debug Request
Core#6: halted 0xffffffc0000802f8 External Debug Request
Core#7: halted 0x0000004000080394 External Debug Request

I think some of the secondary CPUs are not behaving as expected;
As of now I don't have any clues for this.


--Arun
