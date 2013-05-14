From: wlewis569@gmail.com (Walter Lewis)
Date: Mon, 13 May 2013 21:01:08 -0500
Subject: owfs hangup on Linux 3.0.4 using DS28EC20 Dallas 1-wire EEPROM
Message-ID: <40441033-818A-4634-8E02-20567162B98B@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

I am implementing a Maxim 1-Wire DS28EC20 EEPROM on an embedded Linux application with the objective of writing identification information and manufacturing data on a removable component.  I have configured the kernel for 1-Wire support, and have applied the patch for the w1-gpio module implementation. When I insert the w1-gpio module, the /sys/bus/w1 directory becomes present and the target EEPROM is reported.  There is a file present named rw which I can cat (looks binary), but when I pipe data to it, and then read it back, it does not change. I suspect the block nature of the device and its control mechanisms require a more sophisticated write operation. I investigated the owfs which supports read and write on the DS_2433 EEPROM, and am attempting to implement it.  When I do not have the device attached, using owfs, I can 'ls' the owfs mount point.  When a device is attached and the Linux w1 directory (/sys/bus/w1/...) shows it, a 'ls' command on the owfs mount point causes the owfs application to become unresponsive and the ls command never completes. owfs in background mode does not respond to a control C and requires a kill -9 to stop, and once stopped, the ownership and permissions of the owfs mountpoint appear corrupted.  A power cycle restores the mount point. owfs in forground mode does respond to control C and leaves the ownership and permissions in a sane state.

In order to isolate the problem, I have attempted this implementation using owfs with the w1_kernel module and a file system mountpoint; owhttpd with the w1 kernel module and a web page display; and with a owserver with w1 kernel module and a socket connection paired with a owhttpd server attached to the socket connection and a web page display. None of these combinations has solved the hang up condition and output is not to the file system or web page. The 'looking for directory and directory not found' errors occur in owfs, owhttpd and owserver when the component becomes visible to the kernel. I have also tried this with DS2431 EEPROM with the same results.

Below is my system information.  To get to the place where the error occurs, search for: **** ERROR *** . Also, note that the looking for directory and directory not found errors occur in owhttpd and owserver when the component becomes visible to the kernel.

Thank you in advance for your help and assistance.  Please let me know if you need more information or have something you would like me to try.

Walter,

Details:

My target system is a Vendor's TI Omap 4460 based System On a Module, running the omap linux kernel version 3.0.4 (uname -a: Linux <HOST> 3.4.0-1489-omap4 #26~Custom SMP PREEMPT Sat May 11 10:56:25 CDT 2013 armv7l armv7l armv7l GNU/Linux.  I cannot advance this kernel revision until our Vendor supports a newer version. This is cross compiled from a Ubuntu development system, (uname -a: Linux <host> 3.2.0-41-generic #66-Ubuntu SMP Thu Apr 25 03:27:11 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux) with the 'arm-linux-gnueabihf' cross compiler.

My kernel configuration options are:
(1-Wire)
    CONFIG_W1=m
    CONFIG_W1_CON=y
    CONFIG_W1_MASTER_DS1WM=m
    CONFIG_W1_MASTER_DS2482=m
    CONFIG_W1_MASTER_DS2490=m
    CONFIG_W1_MASTER_GPIO=m
    CONFIG_W1_SLAVE_BQ27000=m
    CONFIG_W1_SLAVE_DS2408=m
    CONFIG_W1_SLAVE_DS2423=m
    CONFIG_W1_SLAVE_DS2431=m
    CONFIG_W1_SLAVE_DS2433=m
    # CONFIG_W1_SLAVE_DS2433_CRC is not set
    CONFIG_W1_SLAVE_DS2760=m
    CONFIG_W1_SLAVE_DS2780=m
    # CONFIG_W1_SLAVE_DS2781 is not set
    CONFIG_W1_SLAVE_SMEM=m
    CONFIG_W1_SLAVE_THERM=m
(Fuse)
    CONFIG_FUSE_FS=y

I installed owfs by:
Downloading from SourceForge, the latest version of owfs (owfs-2.9p0.tar.gz), and copied it to the target system.
Logged in as root on the target system, I:
    expanded the download package on the target system, ran configure, make, and make install. 
    owfs was missing because the fuse.h file could not be found. 
    I ran apt-get install libfuse-dev
    I deleted the unzipped owfs directory, and performed the installation again.  This was successful.

I inserted the w1 modules using modprobe.  I have tried this with w1-gpio (+ wire); w1_ds2433 (+ wire); and w1_gpio and w1_ds2433 (+wire).  According to the Maxim datasheet, the DS28EC20 is highly backwards compatible with the 2433 part.

As described above, when the part is attached, the kernel shows the part's presence, bit the owfs mount point hangs up when attempting to display it.

Case 1: owfs implementation

Kernel /sys/bus without modules does not include a w1 directory

Load modules ---
10.20.30.41:/tmp# modprobe w1_gpio
10.20.30.41:/tmp# modprobe w1_ds2433
10.20.30.41:/tmp# lsmod | grep w
w1_ds2433               2233  0
w1_gpio                 1645  0
wire                   26865  2 w1_ds2433,w1_gpio

Kernel /sys/bus after loading modules includes a w1 directory
10.20.30.41:/tmp# ls /sys/bus/w1
total 0
drwxr-xr-x  4 root root    0 May 13 19:32 .
drwxr-xr-x 21 root root    0 Jan  1  2000 ..
drwxr-xr-x  2 root root    0 May 13 19:32 devices
drwxr-xr-x  4 root root    0 May 13 19:32 drivers
-rw-r--r--  1 root root 4.0K May 13 19:32 drivers_autoprobe
--w-------  1 root root 4.0K May 13 19:32 drivers_probe
--w-------  1 root root 4.0K May 13 19:32 uevent
10.20.30.41:/tmp# ls /sys/bus/w1/devices/
total 0
drwxr-xr-x 2 root root 0 May 13 19:32 .
drwxr-xr-x 4 root root 0 May 13 19:32 ..
lrwxrwxrwx 1 root root 0 May 13 19:33 w1_bus_master1 -> ../../../devices/w1_bus_master1

After attaching the 1-Wire EEPROM
10.20.30.41:/tmp# ls /sys/bus/w1/devices/
total 0
drwxr-xr-x 2 root root 0 May 13 19:32 .
drwxr-xr-x 4 root root 0 May 13 19:32 ..
lrwxrwxrwx 1 root root 0 May 13 19:34 43-0000003be97b -> ../../../devices/w1_bus_master1/43-0000003be97b
lrwxrwxrwx 1 root root 0 May 13 19:33 w1_bus_master1 -> ../../../devices/w1_bus_master1

Removed the 1-Wire EEPROM

owfs mount point without EEPROM present or owfs running

10.20.30.41:/tmp# ls /mnt
total 5.0K
drwxr-xr-x  5 root root 1.0K May 13 19:37 .
drwxr-xr-x 23 root root 1.0K May 13 11:33 ..
drwxr-xr-x  2 root root 1.0K Mar 31 19:35 jj
drwxr-xr-x  2 root root 1.0K Oct  9  2012 sda1
drwxr-xr-x  2 root root 1.0K May 13 14:31 w1
10.20.30.41:/tmp# ls /mnt/w1
total 2.0K
drwxr-xr-x 2 root root 1.0K May 13 14:31 .
drwxr-xr-x 5 root root 1.0K May 13 19:37 ..

Run owfs with debugging enabled
10.20.30.41:/tmp# owfs --foreground --error_level=9 --w1 -m /mnt/w1
CONNECT: owfs.c:(96) fuse mount point: /mnt/w1
CONNECT: ow_avahi_link.c:(68) No Avahi support. Library libavahi-client couldn't be loaded
CONNECT: ow_dnssd.c:(82) Zeroconf/Bonjour is disabled since dnssd library isn't found
   CALL: ow_parsename.c:(98) path=[]
  DEBUG: owlib.c:(81) Globals temp limits 0C 100C (for simulated adapters)
  DEBUG: fuse_line.c:(82) Added FUSE option 0 OWFS
  DEBUG: fuse_line.c:(82) Added FUSE option 1 /mnt/w1
  DEBUG: fuse_line.c:(82) Added FUSE option 2 -o
  DEBUG: fuse_line.c:(82) Added FUSE option 3 direct_io
  DEBUG: fuse_line.c:(82) Added FUSE option 4 -f
  DEBUG: fuse_line.c:(82) Added FUSE option 5 -d
  DEBUG: owfs.c:(121) fuse_mnt_opt=[(null)]
  DEBUG: owfs.c:(123) fuse_open_opt=[(null)]
  DEBUG: ow_w1_list.c:(54) Sending w1 bus master list message
  DEBUG: ow_w1_send.c:(132) Netlink send -----------------
NLMSGHDR: len=48 type=3 (NLMSG_DONE) flags=5 seq=0|1 pid=2921
CN_MSG: idx/val=3/1 (CN_W1_IDX) seq=0|1 ack=1 len=12 flags=0
W1_NETLINK_MSG: type=6 (W1_LIST_MASTERS) len=0 id=0
W1_NETLINK_CMD: NULL w1c field
NULL data
  DEBUG: ow_w1_send.c:(143) NETLINK sent seq=1
  DEBUG: ow_w1_dispatch.c:(173) Dispatch loop
  DEBUG: ow_w1_parse.c:(113) Wait to peek at message
  DEBUG: ow_w1_parse.c:(121) Pre-parse header: 16 bytes len=52 type=3 seq=0|1 pid=0
  DEBUG: ow_w1_parse.c:(142) Netlink read -----------------
NLMSGHDR: len=52 type=3 (NLMSG_DONE) flags=0 seq=0|1 pid=0
CN_MSG: idx/val=3/1 (CN_W1_IDX) seq=0|1 ack=0 len=16 flags=12141
W1_NETLINK_MSG: type=6 (W1_LIST_MASTERS) len=4 id=1768713839
W1_NETLINK_CMD: NULL w1c field
Byte buffer Data, length=4
--000: 01 00 00 00
   <....>
  DEBUG: ow_w1_dispatch.c:(88) Netlink message directed to root W1 master
  DEBUG: ow_w1_dispatch.c:(126) Sending this packet to root bus
  DEBUG: ow_w1_dispatch.c:(173) Dispatch loop
  DEBUG: ow_w1_parse.c:(113) Wait to peek at message
  DEBUG: ow_w1_parse.c:(121) Pre-parse header: 16 bytes len=48 type=3 seq=0|1 pid=0
  DEBUG: ow_w1_parse.c:(142) Netlink read -----------------
NLMSGHDR: len=48 type=3 (NLMSG_DONE) flags=0 seq=0|1 pid=0
CN_MSG: idx/val=3/1 (CN_W1_IDX) seq=0|1 ack=1 len=12 flags=0
W1_NETLINK_MSG: type=6 (W1_LIST_MASTERS) len=0 id=0
W1_NETLINK_CMD: NULL w1c field
NULL data
  DEBUG: ow_w1_dispatch.c:(88) Netlink message directed to root W1 master
  DEBUG: ow_w1_dispatch.c:(126) Sending this packet to root bus
  DEBUG: ow_w1_dispatch.c:(173) Dispatch loop
  DEBUG: ow_w1_parse.c:(113) Wait to peek at message
  DEBUG: ow_w1_scan.c:(54) Netlink (w1) list all bus masters
  DEBUG: ow_w1_list.c:(64) W1 List 0 masters
  DEBUG: ow_w1_scan.c:(54) Netlink (w1) list all bus masters
  DEBUG: ow_w1_list.c:(64) W1 List 1 masters
  DEBUG: ow_w1_addremove.c:(55) Setup structure for w1_bus_master1
  DEBUG: ow_w1_addremove.c:(80) Request master be added: w1_bus_master1.
  DEBUG: ow_add_inflight.c:(26) Request master be added: w1_bus_master1
FUSE library version: 2.8.6
nullpath_ok: 0
unique: 1, opcode: INIT (26), nodeid: 0, insize: 56
INIT: 7.18
flags=0x0000047b
max_readahead=0x00020000
   INIT: 7.12
   flags=0x00000011
   max_readahead=0x00020000
   max_write=0x00020000
   unique: 1, success, outsize: 40

owfs mount point without EEPROM present but with owfs running

10.20.30.41:/tmp# ls /mnt
total 4.0K
drwxr-xr-x  5 root root 1.0K May 13 19:37 .
drwxr-xr-x 23 root root 1.0K May 13 11:33 ..
drwxr-xr-x  2 root root 1.0K Mar 31 19:35 jj
drwxr-xr-x  2 root root 1.0K Oct  9  2012 sda1
drwxr-xr-x  1 root root    8 May 13 19:40 w1

Output from owfs during last command
     unique: 2, opcode: GETATTR (3), nodeid: 1, insize: 56
     getattr /
        CALL: ow_fstat.c:(22) path=/
        CALL: ow_parsename.c:(98) path=[/]
        CALL: ow_fstat.c:(39) ATTRIBUTES path=/
      DEBUG: ow_parsename.c:(62) /
        unique: 2, success, outsize: 120
     unique: 3, opcode: GETXATTR (22), nodeid: 1, insize: 65
       unique: 3, error: -38 (Function not implemented), outsize: 16

10.20.30.41:/tmp# ls /mnt/w1
total 1.0K
drwxr-xr-x 1 root root    8 May 13 19:40 .
drwxr-xr-x 5 root root 1.0K May 13 19:37 ..
drwxr-xr-x 1 root root    8 May 13 19:40 bus.0
drwxr-xr-x 1 root root    8 May 13 19:40 bus.1
drwxr-xr-x 1 root root    8 May 13 19:40 settings
drwxr-xr-x 1 root root    8 May 13 19:40 statistics
drwxr-xr-x 1 root root   32 May 13 19:40 structure
drwxr-xr-x 1 root root    8 May 13 19:40 system
drwxr-xr-x 1 root root    8 May 13 19:40 uncached

Output from owfs during last command
     unique: 4, opcode: GETATTR (3), nodeid: 1, insize: 56
     getattr /
        CALL: ow_fstat.c:(22) path=/
        CALL: ow_parsename.c:(98) path=[/]
        CALL: ow_fstat.c:(39) ATTRIBUTES path=/
       DEBUG: ow_parsename.c:(62) /
        unique: 4, success, outsize: 120
     unique: 5, opcode: OPENDIR (27), nodeid: 1, insize: 48
        unique: 5, success, outsize: 32
     unique: 6, opcode: READDIR (28), nodeid: 1, insize: 80
     getdir[0]
        CALL: ow_parsename.c:(98) path=[/]
        CALL: owfs_callback.c:(177) GETDIR path=/
       DEBUG: ow_dir.c:(65) path=/
        CALL: ow_dir.c:(100) path=/
       DEBUG: ow_cache.c:(867) Looking for directory 00 00 00 00 00 00 00 00
       DEBUG: ow_cache.c:(880) Get from cache sn 00 00 00 00 00 00 00 00 pointer=0xb6fa0790 extension=1
       DEBUG: ow_cache.c:(909) Dir not found in cache
       DEBUG: ow_search.c:(32) Start of directory path=/ device=00 00 00 00 00 00 00 00
       DEBUG: ow_w1.c:(125) Sending w1 search (list devices) message
       DEBUG: ow_w1_send.c:(132) Netlink send -----------------
     NLMSGHDR: len=52 type=3 (NLMSG_DONE) flags=5 seq=1|1 pid=2921
     CN_MSG: idx/val=3/1 (CN_W1_IDX) seq=1|1 ack=65537 len=16 flags=0
     W1_NETLINK_MSG: type=4 (W1_MASTER_CMD) len=4 id=1
     W1_NETLINK_CMD: cmd=2 (W1_CMD_SEARCH) len=0
     NULL data
       EBUG: ow_cache.c:(867) Looking for directory 00 00 00 00 00 00 00 00
       DEBUG: ow_cache.c:(880) Get from cache sn 00 00 00 00 00 00 00 00 pointer=0xb6fa0790 extension=0
       DEBUG: ow_cache.c:(909) Dir not found in cache
       DEBUG: ow_w1_parse.c:(121) Pre-parse header: 16 bytes len=52 type=3 seq=1|1 pid=0
       DEBUG: ow_w1_parse.c:(142) Netlink read -----------------
     NLMSGHDR: len=52 type=3 (NLMSG_DONE) flags=0 seq=1|1 pid=0
     CN_MSG: idx/val=3/1 (CN_W1_IDX) seq=1|1 ack=0 len=16 flags=0
     W1_NETLINK_MSG: type=4 (W1_MASTER_CMD) len=4 id=1
     W1_NETLINK_CMD: cmd=2 (W1_CMD_SEARCH) len=0
     NULL data
       DEBUG: ow_w1_dispatch.c:(92) Netlink message directed to W1 bus master 1
       DEBUG: ow_w1_dispatch.c:(149) Sending this packet to w1_bus_master1
       DEBUG: ow_w1_dispatch.c:(173) Dispatch loop
       DEBUG: ow_w1_parse.c:(113) Wait to peek at message
       DEBUG: ow_w1_parse.c:(121) Pre-parse header: 16 bytes len=52 type=3 seq=1|1 pid=0
       DEBUG: ow_w1_parse.c:(142) Netlink read -----------------
     NLMSGHDR: len=52 type=3 (NLMSG_DONE) flags=0 seq=1|1 pid=0
     CN_MSG: idx/val=3/1 (CN_W1_IDX) seq=1|1 ack=65537 len=16 flags=0
     W1_NETLINK_MSG: type=4 (W1_MASTER_CMD) len=4 id=1
     W1_NETLINK_CMD: cmd=2 (W1_CMD_SEARCH) len=0
     NULL data
       DEBUG: ow_w1_dispatch.c:(92) Netlink message directed to W1 bus master 1
       DEBUG: ow_w1_dispatch.c:(149) Sending this packet to w1_bus_master1
       DEBUG: ow_w1_dispatch.c:(173) Dispatch loop
       EBUG: ow_w1_parse.c:(113) Wait to peek at message
       DEBUG: ow_w1_send.c:(143) NETLINK sent seq=1
       DEBUG: ow_w1_parse.c:(225) Loop waiting for netlink piped message
       DEBUG: ow_w1_parse.c:(163) Pipe header: len=52 type=3 seq=1|1 pid=0
       DEBUG: ow_w1_parse.c:(191) Pipe read --------------------
     NLMSGHDR: len=52 type=3 (NLMSG_DONE) flags=0 seq=1|1 pid=0
     CN_MSG: idx/val=3/1 (CN_W1_IDX) seq=1|1 ack=0 len=16 flags=0
     W1_NETLINK_MSG: type=4 (W1_MASTER_CMD) len=4 id=1
     W1_NETLINK_CMD: cmd=2 (W1_CMD_SEARCH) len=0
     NULL data
       DEBUG: ow_w1_parse.c:(245) About to call nrs_callback
       DEBUG: ow_w1_parse.c:(247) Called nrs_callback
       DEBUG: ow_w1_parse.c:(225) Loop waiting for netlink piped message
       DEBUG: ow_w1_parse.c:(163) Pipe header: len=52 type=3 seq=1|1 pid=0
       DEBUG: ow_w1_parse.c:(191) Pipe read --------------------
     NLMSGHDR: len=52 type=3 (NLMSG_DONE) flags=0 seq=1|1 pid=0
     CN_MSG: idx/val=3/1 (CN_W1_IDX) seq=1|1 ack=65537 len=16 flags=0
     W1_NETLINK_MSG: type=4 (W1_MASTER_CMD) len=4 id=1
     W1_NETLINK_CMD: cmd=2 (W1_CMD_SEARCH) len=0
     NULL data
       DEBUG: ow_w1.c:(201) SN finished
        CALL: ow_parsename.c:(98) path=[/bus.1]
       DEBUG: ow_parsename.c:(62) /bus.1
        CALL: ow_parsename.c:(98) path=[/bus.0]
       DEBUG: ow_parsename.c:(62) /bus.0
        CALL: ow_parsename.c:(98) path=[/uncached]
       DEBUG: ow_parsename.c:(62) /uncached
        CALL: ow_parsename.c:(98) path=[/settings]
       DEBUG: ow_parsename.c:(62) /settings
        CALL: ow_parsename.c:(98) path=[/system]
       DEBUG: ow_parsename.c:(62) /system
        CALL: ow_parsename.c:(98) path=[/statistics]
       DEBUG: ow_parsename.c:(62) /statistics
        CALL: ow_parsename.c:(98) path=[/structure]
       DEBUG: ow_parsename.c:(62) /structure
       DEBUG: ow_dir.c:(195) ret=0
       DEBUG: ow_parsename.c:(62) /
        unique: 6, success, outsize: 320
     unique: 7, opcode: LOOKUP (1), nodeid: 1, insize: 46
     LOOKUP /bus.1
     getattr /bus.1
        CALL: ow_fstat.c:(22) path=/bus.1
        CALL: ow_parsename.c:(98) path=[/bus.1]
        CALL: ow_fstat.c:(39) ATTRIBUTES path=/bus.1
       DEBUG: ow_parsename.c:(62) /bus.1
        NODEID: 2
        unique: 7, success, outsize: 144
     unique: 8, opcode: LOOKUP (1), nodeid: 1, insize: 46
     LOOKUP /bus.0
     getattr /bus.0
        CALL: ow_fstat.c:(22) path=/bus.0
        CALL: ow_parsename.c:(98) path=[/bus.0]
        CALL: ow_fstat.c:(39) ATTRIBUTES path=/bus.0
       DEBUG: ow_parsename.c:(62) /bus.0
        NODEID: 3
        unique: 8, success, outsize: 144
     unique: 9, opcode: LOOKUP (1), nodeid: 1, insize: 49
     LOOKUP /uncached
     getattr /uncached
        CALL: ow_fstat.c:(22) path=/uncached
        CALL: ow_parsename.c:(98) path=[/uncached]
        CALL: ow_fstat.c:(39) ATTRIBUTES path=/uncached
       DEBUG: ow_parsename.c:(62) /uncached
        NODEID: 4
        unique: 9, success, outsize: 144
     unique: 10, opcode: LOOKUP (1), nodeid: 1, insize: 49
     LOOKUP /settings
     getattr /settings
        CALL: ow_fstat.c:(22) path=/settings
        CALL: ow_parsename.c:(98) path=[/settings]
        ALL: ow_fstat.c:(39) ATTRIBUTES path=/settings
       DEBUG: ow_parsename.c:(62) /settings
        NODEID: 5
        unique: 10, success, outsize: 144
     unique: 11, opcode: LOOKUP (1), nodeid: 1, insize: 47
     LOOKUP /system
     getattr /system
        CALL: ow_fstat.c:(22) path=/system
        CALL: ow_parsename.c:(98) path=[/system]
        CALL: ow_fstat.c:(39) ATTRIBUTES path=/system
       DEBUG: ow_parsename.c:(62) /system
        NODEID: 6
        unique: 11, success, outsize: 144
     unique: 12, opcode: LOOKUP (1), nodeid: 1, insize: 51
     LOOKUP /statistics
     getattr /statistics
        CALL: ow_fstat.c:(22) path=/statistics
        CALL: ow_parsename.c:(98) path=[/statistics]
        CALL: ow_fstat.c:(39) ATTRIBUTES path=/statistics
       DEBUG: ow_parsename.c:(62) /statistics
        NODEID: 7
        unique: 12, success, outsize: 144
     unique: 13, opcode: LOOKUP (1), nodeid: 1, insize: 50
     LOOKUP /structure
     getattr /structure
        CALL: ow_fstat.c:(22) path=/structure
        CALL: ow_parsename.c:(98) path=[/structure]
        CALL: ow_fstat.c:(39) ATTRIBUTES path=/structure
       DEBUG: ow_parsename.c:(62) /structure
        NODEID: 8
        unique: 13, success, outsize: 144
     unique: 14, opcode: GETATTR (3), nodeid: 1, insize: 56
     getattr /
        CALL: ow_fstat.c:(22) path=/
        CALL: ow_parsename.c:(98) path=[/]
       CALL: ow_fstat.c:(39) ATTRIBUTES path=/
       DEBUG: ow_parsename.c:(62) /
        unique: 14, success, outsize: 120
     unique: 15, opcode: READDIR (28), nodeid: 1, insize: 80
        unique: 15, success, outsize: 16
     unique: 16, opcode: RELEASEDIR (29), nodeid: 1, insize: 64
        unique: 16, success, outsize: 16

Attaching the 1-wire EEPROM
     output from owfs
       DEBUG: ow_w1_parse.c:(121) Pre-parse header: 16 bytes len=48 type=3 seq=0|4 pid=0
       DEBUG: ow_w1_parse.c:(142) Netlink read -----------------
     NLMSGHDR: len=48 type=3 (NLMSG_DONE) flags=0 seq=0|4 pid=0
     CN_MSG: idx/val=3/1 (CN_W1_IDX) seq=0|4 ack=0 len=12 flags=0
     W1_NETLINK_MSG: type=0 (W1_SLAVE_ADD) len=0 id=1005157187
     W1_NETLINK_CMD: NULL w1c field
     NULL data
       DEBUG: ow_w1_dispatch.c:(88) Netlink message directed to root W1 master
       DEBUG: ow_w1_dispatch.c:(126) Sending this packet to root bus
       DEBUG: ow_w1_dispatch.c:(173) Dispatch loop
       DEBUG: ow_w1_parse.c:(113) Wait to peek at message
       DEBUG: ow_w1_scan.c:(69) Netlink (w1) Slave announcements (ignored)

ls on owfs mountpoint - **** ERROR *** - no output, hanges
10.20.30.41:/tmp# ls /mnt/w1

Output from owfs during last command
     unique: 17, opcode: GETATTR (3), nodeid: 1, insize: 56
     getattr /
        CALL: ow_fstat.c:(22) path=/
        CALL: ow_parsename.c:(98) path=[/]
        CALL: ow_fstat.c:(39) ATTRIBUTES path=/
       DEBUG: ow_parsename.c:(62) /
        unique: 17, success, outsize: 120
     unique: 18, opcode: OPENDIR (27), nodeid: 1, insize: 48
        unique: 18, success, outsize: 32
     unique: 19, opcode: READDIR (28), nodeid: 1, insize: 80
     getdir[0]
        CALL: ow_parsename.c:(98) path=[/]
        CALL: owfs_callback.c:(177) GETDIR path=/
       DEBUG: ow_dir.c:(65) path=/
        CALL: ow_dir.c:(100) path=/
       DEBUG: ow_cache.c:(867) Looking for directory 00 00 00 00 00 00 00 00
       DEBUG: ow_cache.c:(880) Get from cache sn 00 00 00 00 00 00 00 00 pointer=0xb6fa0790 extension=1
       DEBUG: ow_cache.c:(867) Looking for directory 00 00 00 00 00 00 00 00
      DEBUG: ow_cache.c:(880) Get from cache sn 00 00 00 00 00 00 00 00 pointer=0xb6fa0790 extension=0
      DEBUG: ow_cache.c:(909) Dir not found in cache
      DEBUG: ow_cache.c:(909) Dir not found in cache
      DEBUG: ow_search.c:(32) Start of directory path=/ device=00 00 00 00 00 00 00 00
       DEBUG: ow_w1.c:(125) Sending w1 search (list devices) message
      DEBUG: ow_w1_send.c:(132) Netlink send -----------------
     NLMSGHDR: len=52 type=3 (NLMSG_DONE) flags=5 seq=1|2 pid=2921
     CN_MSG: idx/val=3/1 (CN_W1_IDX) seq=1|2 ack=65538 len=16 flags=0
     W1_NETLINK_MSG: type=4 (W1_MASTER_CMD) len=4 id=1
     W1_NETLINK_CMD: cmd=2 (W1_CMD_SEARCH) len=0
     NULL data
