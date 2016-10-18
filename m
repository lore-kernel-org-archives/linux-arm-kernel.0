From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 18 Oct 2016 17:29:58 +0100
Subject: [PATCH 1/2] scripts/gdb: add lx-fdtdump command
In-Reply-To: <0143426e-7e92-aaff-7641-519e1f63e075@siemens.com>
References: <1476803249-23328-1-git-send-email-peter.griffin@linaro.org>
 <c8a1898e-e60f-b25a-f4d2-7384f04b6f3f@siemens.com>
 <20161018160638.GA24851@griffinp-ThinkPad-X1-Carbon-2nd>
 <0143426e-7e92-aaff-7641-519e1f63e075@siemens.com>
Message-ID: <20161018162958.GA28359@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,

On Tue, 18 Oct 2016, Jan Kiszka wrote:

> On 2016-10-18 18:06, Peter Griffin wrote:
> > Hi Jan,
> > 
> > On Tue, 18 Oct 2016, Jan Kiszka wrote:
> > 
> >> On 2016-10-18 17:07, Peter Griffin wrote:
> >>> lx-fdtdump dumps the flatenned device tree passed to the kernel
> >>> from the bootloader to a file called fdtdump.dtb to allow further
> >>> post processing on the machine running GDB. The fdt header is also
> >>> also printed in the GDB console. For example:
> >>>
> >>> (gdb) lx-fdtdump
> >>> fdt_magic:         0xD00DFEED
> >>> fdt_totalsize:     0xC108
> >>> off_dt_struct:     0x38
> >>> off_dt_strings:    0x3804
> >>> off_mem_rsvmap:    0x28
> >>> version:           17
> >>> last_comp_version: 16
> >>> Dumped fdt to fdtdump.dtb
> >>>
> >>>> fdtdump fdtdump.dtb | less
> >>>
> >>> This command is useful as the bootloader can often re-write parts
> >>> of the device tree, and this can sometimes cause the kernel to not
> >>> boot.
> >>>
> >>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> >>> ---
> >>>  scripts/gdb/linux/constants.py.in |  8 +++++
> >>>  scripts/gdb/linux/proc.py         | 70 ++++++++++++++++++++++++++++++++++++++-
> >>>  2 files changed, 77 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
> >>> index 7986f4e..43c6241 100644
> >>> --- a/scripts/gdb/linux/constants.py.in
> >>> +++ b/scripts/gdb/linux/constants.py.in
> >>> @@ -14,6 +14,7 @@
> >>>  
> >>>  #include <linux/fs.h>
> >>>  #include <linux/mount.h>
> >>> +#include <linux/of_fdt.h>
> >>>  
> >>>  /* We need to stringify expanded macros so that they can be parsed */
> >>>  
> >>> @@ -50,3 +51,10 @@ LX_VALUE(MNT_NOEXEC)
> >>>  LX_VALUE(MNT_NOATIME)
> >>>  LX_VALUE(MNT_NODIRATIME)
> >>>  LX_VALUE(MNT_RELATIME)
> >>> +
> >>> +/* linux/of_fdt.h> */
> >>> +LX_VALUE(OF_DT_HEADER)
> >>> +
> >>> +/* Kernel Configs */
> >>> +LX_CONFIG(CONFIG_OF)
> >>> +
> >>> diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
> >>> index 38b1f09..f20fcfa 100644
> >>> --- a/scripts/gdb/linux/proc.py
> >>> +++ b/scripts/gdb/linux/proc.py
> >>> @@ -16,7 +16,7 @@ from linux import constants
> >>>  from linux import utils
> >>>  from linux import tasks
> >>>  from linux import lists
> >>> -
> >>> +from struct import *
> >>>  
> >>>  class LxCmdLine(gdb.Command):
> >>>      """ Report the Linux Commandline used in the current kernel.
> >>> @@ -195,3 +195,71 @@ values of that process namespace"""
> >>>                          info_opts(MNT_INFO, m_flags)))
> >>>  
> >>>  LxMounts()
> >>> +
> >>> +class LxFdtDump(gdb.Command):
> >>> +    """Output Flattened Device Tree header and dump FDT blob to a file
> >>> +       Equivalent to 'cat /proc/fdt > fdtdump.dtb' on a running target"""
> >>> +
> >>> +    def __init__(self):
> >>> +        super(LxFdtDump, self).__init__("lx-fdtdump", gdb.COMMAND_DATA)
> >>> +
> >>> +    def fdthdr_to_cpu(self, fdt_header):
> >>> +
> >>> +            fdt_header_be = ">IIIIIII"
> >>> +            fdt_header_le = "<IIIIIII"
> >>> +
> >>> +            if utils.get_target_endianness() == 1:
> >>> +                output_fmt = fdt_header_le
> >>> +            else:
> >>> +                output_fmt = fdt_header_be
> >>> +
> >>> +            return unpack(output_fmt, pack(fdt_header_be,
> >>> +                                           fdt_header['magic'],
> >>> +                                           fdt_header['totalsize'],
> >>> +                                           fdt_header['off_dt_struct'],
> >>> +                                           fdt_header['off_dt_strings'],
> >>> +                                           fdt_header['off_mem_rsvmap'],
> >>> +                                           fdt_header['version'],
> >>> +                                           fdt_header['last_comp_version']))
> >>> +
> >>> +    def invoke(self, arg, from_tty):
> >>> +
> >>> +        if constants.LX_CONFIG_OF:
> >>> +
> >>> +            filename = "fdtdump.dtb"
> >>
> >> Why not specifying the file name as argument? Safer than silently
> >> overwriting potentially pre-existing files or failing without
> >> alternatives if the current directory is not writable.
> > 
> > Good idea, I will update to have the filename as the command argument in v2.
> > 
> 
> Also check gdb.COMPLETE_FILENAME [1] at that chance. :)
> 
> Jan
> 
> [1]
> https://sourceware.org/gdb/onlinedocs/gdb/Commands-In-Python.html#Commands-In-Python
> 

Thanks for the tip, that is very cool!

Will add gdb.COMPLETE_FILENAME in V2.

regads,

Peter.
