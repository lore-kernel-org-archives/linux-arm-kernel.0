From: kieran@bingham.xyz (Kieran Bingham)
Date: Tue, 18 Oct 2016 16:56:39 +0100
Subject: [PATCH 1/2] scripts/gdb: add lx-fdtdump command
In-Reply-To: <1476803249-23328-1-git-send-email-peter.griffin@linaro.org>
References: <1476803249-23328-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <a440581a-e28c-2f9f-8110-26203e0b3809@bingham.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pete,

Thanks for your patch.

On 18/10/16 16:07, Peter Griffin wrote:
> lx-fdtdump dumps the flatenned device tree passed to the kernel

s/flatenned/flattened/

> from the bootloader to a file called fdtdump.dtb to allow further
> post processing on the machine running GDB. The fdt header is also
> also printed in the GDB console. For example:
> 

Excellent - I've been looking forward to this

General comment: It would be good to see the output filename
configurable as a parameter, defaulting to fdtdump.dtb if none provided.

Is this something you have time to add?

> (gdb) lx-fdtdump
> fdt_magic:         0xD00DFEED
> fdt_totalsize:     0xC108
> off_dt_struct:     0x38
> off_dt_strings:    0x3804
> off_mem_rsvmap:    0x28
> version:           17
> last_comp_version: 16
> Dumped fdt to fdtdump.dtb
> 
>> fdtdump fdtdump.dtb | less
> 
> This command is useful as the bootloader can often re-write parts
> of the device tree, and this can sometimes cause the kernel to not
> boot.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  scripts/gdb/linux/constants.py.in |  8 +++++
>  scripts/gdb/linux/proc.py         | 70 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
> index 7986f4e..43c6241 100644
> --- a/scripts/gdb/linux/constants.py.in
> +++ b/scripts/gdb/linux/constants.py.in
> @@ -14,6 +14,7 @@
>  
>  #include <linux/fs.h>
>  #include <linux/mount.h>
> +#include <linux/of_fdt.h>
>  
>  /* We need to stringify expanded macros so that they can be parsed */
>  
> @@ -50,3 +51,10 @@ LX_VALUE(MNT_NOEXEC)
>  LX_VALUE(MNT_NOATIME)
>  LX_VALUE(MNT_NODIRATIME)
>  LX_VALUE(MNT_RELATIME)
> +
> +/* linux/of_fdt.h> */
> +LX_VALUE(OF_DT_HEADER)
> +
> +/* Kernel Configs */
> +LX_CONFIG(CONFIG_OF)
> +
> diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
> index 38b1f09..f20fcfa 100644
> --- a/scripts/gdb/linux/proc.py
> +++ b/scripts/gdb/linux/proc.py
> @@ -16,7 +16,7 @@ from linux import constants
>  from linux import utils
>  from linux import tasks
>  from linux import lists
> -
> +from struct import *
>  
>  class LxCmdLine(gdb.Command):
>      """ Report the Linux Commandline used in the current kernel.
> @@ -195,3 +195,71 @@ values of that process namespace"""
>                          info_opts(MNT_INFO, m_flags)))
>  
>  LxMounts()
> +
> +class LxFdtDump(gdb.Command):
> +    """Output Flattened Device Tree header and dump FDT blob to a file
> +       Equivalent to 'cat /proc/fdt > fdtdump.dtb' on a running target"""
> +
> +    def __init__(self):
> +        super(LxFdtDump, self).__init__("lx-fdtdump", gdb.COMMAND_DATA)
> +
> +    def fdthdr_to_cpu(self, fdt_header):
> +
> +            fdt_header_be = ">IIIIIII"
> +            fdt_header_le = "<IIIIIII"
> +
> +            if utils.get_target_endianness() == 1:
> +                output_fmt = fdt_header_le
> +            else:
> +                output_fmt = fdt_header_be
> +
> +            return unpack(output_fmt, pack(fdt_header_be,
> +                                           fdt_header['magic'],
> +                                           fdt_header['totalsize'],
> +                                           fdt_header['off_dt_struct'],
> +                                           fdt_header['off_dt_strings'],
> +                                           fdt_header['off_mem_rsvmap'],
> +                                           fdt_header['version'],
> +                                           fdt_header['last_comp_version']))
> +
> +    def invoke(self, arg, from_tty):
> +
> +        if constants.LX_CONFIG_OF:
> +
> +            filename = "fdtdump.dtb"
> +

You could parse the arguments here to allow users to write to their own
file / path ... arg is just a string, so you can either parse it as such
or convert to argv with
	argv = gdb.string_to_argv(arg)


Aha - I see Jan beat me to it :)


> +            py_fdt_header_ptr = gdb.parse_and_eval(
> +                "(const struct fdt_header *) initial_boot_params")
> +            py_fdt_header = py_fdt_header_ptr.dereference()
> +
> +            fdt_header = self.fdthdr_to_cpu(py_fdt_header)
> +
> +            if fdt_header[0] != constants.LX_OF_DT_HEADER:
> +                raise gdb.GdbError("No flattened device tree magic found\n")
> +
> +            gdb.write("fdt_magic:         0x{:02X}\n".format(fdt_header[0]))
> +            gdb.write("fdt_totalsize:     0x{:02X}\n".format(fdt_header[1]))
> +            gdb.write("off_dt_struct:     0x{:02X}\n".format(fdt_header[2]))
> +            gdb.write("off_dt_strings:    0x{:02X}\n".format(fdt_header[3]))
> +            gdb.write("off_mem_rsvmap:    0x{:02X}\n".format(fdt_header[4]))
> +            gdb.write("version:           {}\n".format(fdt_header[5]))
> +            gdb.write("last_comp_version: {}\n".format(fdt_header[6]))
> +
> +            inf = gdb.inferiors()[0]
> +            fdt_buf = utils.read_memoryview(inf, py_fdt_header_ptr,
> +                                            fdt_header[1]).tobytes()
> +
> +            try:
> +                f = open(filename, 'wb')
> +            except:
> +                raise gdb.GdbError("Could not open file to dump fdt")
> +
> +            f.write(fdt_buf)
> +            f.close()
> +
> +            gdb.write("Dumped fdt to " + filename + "\n")
> +
> +        else:
> +            gdb.write("Kernel not compiled with CONFIG_OF\n")

Would it be cleaner to write
  if not constants.LX_CONFIG_OF:
      raise gdb.GdbError("Kernel not compiled with CONFIG_OF\n")

at the beginning, and reduce the indentation level required ?

> +
> +LxFdtDump()
> 

-- 
Regards

Kieran Bingham
