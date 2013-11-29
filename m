From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 30 Nov 2013 00:25:14 +0100
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <20131128185040.GA13182@localhost> (Ezequiel Garcia's message of
 "Thu, 28 Nov 2013 15:50:41 -0300")
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <87d2lp28pd.fsf@natisbad.org> <20131125120335.GD2408@localhost>
 <87r4a4f5gr.fsf@natisbad.org> <20131126124003.GA2344@localhost>
 <87zjopd240.fsf@natisbad.org> <87wqjtbm8r.fsf@natisbad.org>
 <20131128185040.GA13182@localhost>
Message-ID: <87bo12kcyt.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Ezequiel Garcia <ezequiel.garcia@free-electrons.com> writes:

>> Ezequiel, I am back in business to test a v2 ;-)
>
> Well, I'm not sure yet what's going on. Do you have any spare NAND partition
> to run some destructive testings?
>
> In that case, please run:
>
> $ nandtest /dev/mtd{X}

Here is the nandtest run:

  nandtest /dev/mtd4
  ECC corrections: 0
  ECC failures   : 0
  Bad blocks     : 8
  BBT blocks     : 0
  Bad block at 0x06700000
  Bad block at 0x06720000
  Bad block at 0x06740000
  Bad block at 0x06760000
  Bad block at 0x06780000
  Bad block at 0x067a0000
  Bad block at 0x067c0000
  Bad block at 0x067e0000
  
  Finished pass 1 successfully


Then, doing a simple read and copying back the data:

  root at mood:~# dd if=/dev/mtd4 of=/tmp/toto 
  212992+0 records in
  212992+0 records out
  109051904 bytes (109 MB) copied, 10.8671 s, 10.0 MB/s
  
  root at mood:~# flash_erase /dev/mtd4 0 0
  flash_erase: Skipping bad block at 06700000
  flash_erase: Skipping bad block at 06720000
  flash_erase: Skipping bad block at 06740000
  flash_erase: Skipping bad block at 06760000
  flash_erase: Skipping bad block at 06780000
  flash_erase: Skipping bad block at 067a0000
  flash_erase: Skipping bad block at 067c0000
  flash_erase: Skipping bad block at 067e0000
  
  root at mood:~# nandwrite -p /dev/mtd4 /tmp/toto
  Writing data to block 0 at offset 0x0
  Writing data to block 1 at offset 0x20000
  Writing data to block 2 at offset 0x40000
  Writing data to block 3 at offset 0x60000
  Writing data to block 4 at offset 0x80000
  Writing data to block 5 at offset 0xa0000
  Writing data to block 6 at offset 0xc0000
  Writing data to block 7 at offset 0xe0000
  ...
  Writing data to block 795 at offset 0x6360000
  Writing data to block 796 at offset 0x6380000
  Writing data to block 797 at offset 0x63a0000
  Writing data to block 798 at offset 0x63c0000
  Writing data to block 799 at offset 0x63e0000
  Writing data to block 800 at offset 0x6400000
  [ 1509.210395] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 800, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x6400000 to 0x641ffff
  Writing data to block 801 at offset 0x6420000
  [ 1509.410388] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 801, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x6420000 to 0x643ffff
  Writing data to block 802 at offset 0x6440000
  [ 1509.610386] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 802, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x6440000 to 0x645ffff
  Writing data to block 803 at offset 0x6460000
  [ 1509.810386] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 803, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x6460000 to 0x647ffff
  Writing data to block 804 at offset 0x6480000
  [ 1510.010387] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 804, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x6480000 to 0x649ffff
  Writing data to block 805 at offset 0x64a0000
  [ 1510.210386] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 805, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x64a0000 to 0x64bffff
  Writing data to block 806 at offset 0x64c0000
  [ 1510.410386] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 806, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x64c0000 to 0x64dffff
  Writing data to block 807 at offset 0x64e0000
  [ 1510.610387] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 807, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x64e0000 to 0x64fffff
  Writing data to block 808 at offset 0x6500000
  [ 1510.810386] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 808, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x6500000 to 0x651ffff
  Writing data to block 809 at offset 0x6520000
  [ 1511.010385] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 809, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x6520000 to 0x653ffff
  Writing data to block 810 at offset 0x6540000
  [ 1511.210387] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 810, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x6540000 to 0x655ffff
  Writing data to block 811 at offset 0x6560000
  [ 1511.410387] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 811, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x6560000 to 0x657ffff
  Writing data to block 812 at offset 0x6580000
  [ 1511.610388] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 812, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x6580000 to 0x659ffff
  Writing data to block 813 at offset 0x65a0000
  [ 1511.810444] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 813, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x65a0000 to 0x65bffff
  Writing data to block 814 at offset 0x65c0000
  [ 1512.010387] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 814, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x65c0000 to 0x65dffff
  Writing data to block 815 at offset 0x65e0000
  [ 1512.210386] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 815, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x65e0000 to 0x65fffff
  Writing data to block 816 at offset 0x6600000
  [ 1512.410386] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 816, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x6600000 to 0x661ffff
  Writing data to block 817 at offset 0x6620000
  [ 1512.610386] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 817, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x6620000 to 0x663ffff
  Writing data to block 818 at offset 0x6640000
  [ 1512.810386] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 818, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x6640000 to 0x665ffff
  Writing data to block 819 at offset 0x6660000
  [ 1513.010386] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 819, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x6660000 to 0x667ffff
  Writing data to block 820 at offset 0x6680000
  [ 1513.210386] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 820, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x6680000 to 0x669ffff
  Writing data to block 821 at offset 0x66a0000
  [ 1513.410386] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 821, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x66a0000 to 0x66bffff
  Writing data to block 822 at offset 0x66c0000
  [ 1513.610388] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 822, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x66c0000 to 0x66dffff
  Writing data to block 823 at offset 0x66e0000
  [ 1513.810387] pxa3xx-nand d00d0000.nand: Ready time out!!!
  libmtd: error!: cannot write 2048 bytes to mtd4 (eraseblock 823, offset 0)
          error 5 (Input/output error)
  Erasing failed write from 0x66e0000 to 0x66fffff
  Writing data to block 824 at offset 0x6700000
  Bad block at 6700000, 1 block(s) from 6700000 will be skipped
  Writing data to block 825 at offset 0x6720000
  Bad block at 6720000, 1 block(s) from 6720000 will be skipped
  Writing data to block 826 at offset 0x6740000
  Bad block at 6740000, 1 block(s) from 6740000 will be skipped
  Writing data to block 827 at offset 0x6760000
  Bad block at 6760000, 1 block(s) from 6760000 will be skipped
  Writing data to block 828 at offset 0x6780000
  Bad block at 6780000, 1 block(s) from 6780000 will be skipped
  Writing data to block 829 at offset 0x67a0000
  Bad block at 67a0000, 1 block(s) from 67a0000 will be skipped
  Writing data to block 830 at offset 0x67c0000
  Bad block at 67c0000, 1 block(s) from 67c0000 will be skipped
  Writing data to block 831 at offset 0x67e0000
  Bad block at 67e0000, 1 block(s) from 67e0000 will be skipped
  Writing data to block 832 at offset 0x6800000
  libmtd: error!: bad eraseblock number 832, mtd4 has 832 eraseblocks
  nandwrite: error!: /dev/mtd4: MTD get bad block failed
             error 22 (Invalid argument)
  nandwrite: error!: Data was only partially written due to error
             error 22 (Invalid argument)
  
This is the kind of errors I got last time but I think am starting to
understand the root cause now. Tell me if I get it right: what is
understood as bad blocks above (and in nandtest) is in fact the two bad
block tables reported during boot:

 NAND device: Manufacturer ID: 0xad, Chip ID: 0xf1 (Hynix H27U1G8F2BTR-BC)
 NAND device: 128MiB, SLC, page size: 2048, OOB size: 64
 Bad block table found at page 65472, version 0x01
 Bad block table found at page 65408, version 0x01

*If* that is the case, 

 1) I think your driver works as expected

 2) I also think I should reduce partition definition from 

         partition at 1800000 {
                 label = "jffs2";
                 reg = <0x1800000 0x6800000>;
         };
   to
         partition at 1800000 { /* Followed by 256KB of BBT */
                 label = "jffs2";
                 reg = <0x1800000 0x67c0000>;
         };

In that case, I wonder if there some automatic way to have the
*effective* size of that last partition computed from start position,
chip size and bad block tables positions and size? Or hardcoding the
value is ok?

I took a look at devicetree bindings for MTD partitions (partitions.txt)
but found nothing. Looking at existing .dts files, I wonder if 0 as a
specific meaning:

$ grep -A3 partition@ *.dts | grep -A 1 root 
...
--
spear1310-evb.dts-                              label = "rootfs";
spear1310-evb.dts-                              reg = <0xE40000 0x0>;
--
spear1310-evb.dts-                                      label = "rootfs";
spear1310-evb.dts-                                      reg = <0x390000 0x0>;
--
spear1340-evb.dts-                              label = "rootfs";
spear1340-evb.dts-                              reg = <0x1200000 0x0>;
--
spear1340-evb.dts-                                      label = "rootfs";
spear1340-evb.dts-                                      reg = <0x390000 0x0>;
--
spear300-evb.dts-                                       label = "rootfs";
spear300-evb.dts-                                       reg = <0x390000 0x0>;
--
spear310-evb.dts-                                       label = "rootfs";
spear310-evb.dts-                                       reg = <0x390000 0x0>;
--
spear320-evb.dts-                                       label = "rootfs";
spear320-evb.dts-                                       reg = <0x390000 0x0>;
--
spear320-hmi.dts-                               label = "rootfs";
spear320-hmi.dts-                               reg = <0xE40000 0x0>;
--
spear320-hmi.dts-                                       label = "rootfs";
spear320-hmi.dts-                                       reg = <0x390000 0x0>;
--
spear600-evb.dts-                                       label = "rootfs";
spear600-evb.dts-                                       reg = <0x390000 0x0>;


As a side note, if I am somewhat right, I wonder how the defintion of
the partitions in for instance armada-370-mirabox.dts (introduced by
016b74660d14) would allow to effectively use the end of that partition:

         nand at d0000 {
                 status = "okay";
                 num-cs = <1>;
                 marvell,nand-keep-config;
                 marvell,nand-enable-arbiter;
                 nand-on-flash-bbt;
 
                 partition at 0 {
                         label = "U-Boot";
                         reg = <0 0x400000>;
                 };
                 partition at 400000 {
                         label = "Linux";
                         reg = <0x400000 0x400000>;
                 };
                 partition at 800000 {
                         label = "Filesystem";
                         reg = <0x800000 0x3f800000>;
                 };
        };

Comments welcome.

Cheers,

a+
