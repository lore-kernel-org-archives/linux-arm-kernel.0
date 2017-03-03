From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Mar 2017 17:46:43 +0000
Subject: No output on console despite ignore_loglevel earlyprintk
In-Reply-To: <3293964b-aec2-e8b8-46f5-49b0eacc4718@suse.de>
References: <6d16a384-1a4c-bf27-fd81-ea3caf3de6b0@sigmadesigns.com>
 <20170303165548.GO21222@n2100.armlinux.org.uk>
 <3293964b-aec2-e8b8-46f5-49b0eacc4718@suse.de>
Message-ID: <20170303174643.GQ21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 06:26:28PM +0100, Andreas F?rber wrote:
> Am 03.03.2017 um 17:55 schrieb Russell King - ARM Linux:
> > On Fri, Mar 03, 2017 at 05:42:02PM +0100, Marc Gonzalez wrote:
> >> I'm confused about early consoles and earlyprintk, and all that good stuff.
> >> When my kernel panics, I don't get the expected output.
> >>
> >> Using "mem=256M ignore_loglevel earlyprintk"
> >>
> [...]
> >> [    0.014325] Console: colour dummy device 80x30
> >> [    0.018885] console [tty0] enabled
> >> [    0.022396] bootconsole [earlycon0] disabled
> >>
> >> And it hangs there.
> > 
> > tty0 is the kernel virtual terminal console, which is what appears on
> > VGA or framebuffers.  This is the default console if nothing else is
> > specified.
> > 
> > What happened here is that the virtual terminal console registered, was
> > detected to be the system console, so early console was shut down, and
> > the boot messages logged to the virtual terminal console instead.
> 
> Why does passing console= make a difference though?
> 
> I expect stdout-path to have the same effect as the command line, and I
> am pretty sure that that was previous behavior in, e.g., v4.4.
> 
> Note that I am using earlycon, as opposed to earlyprintk above.

The property is:

	stdout-path = "dt-node-name:hw-parameters";

and this is parsed by the code in drivers/of/fdt.c,
early_init_dt_scan_chosen_stdout() (briefly):

        offset = fdt_path_offset(fdt, "/chosen");
        p = fdt_getprop(fdt, offset, "stdout-path", &l);

        q = strchrnul(p, ':');
        if (*q != '\0')
                options = q + 1;
        l = q - p;

        /* Get the node specified by stdout-path */
        offset = fdt_path_offset_namelen(fdt, p, l);
        if (offset < 0) {
                pr_warn("earlycon: stdout-path %.*s not found\n", l, p);

So here, offset points@the node named by "dt-node-name" above.

This function then tries to patch the specified node's compatible with
the drivers in the __earlycon_table:

        for (match = __earlycon_table; match < __earlycon_table_end; match++) {
                if (!match->compatible[0])
                        continue;

                if (fdt_node_check_compatible(fdt, offset, match->compatible))
                        continue;

and when a match is found, calls:

                of_setup_earlycon(match, offset, options);

Here, we go into the code in drivers/tty/serial/earlycon.c, which reads
the standard properties (like "reg", etc) filling out a uart_port
before calling the early console's ->setup method.  If everything goes
to plan, register_console() is called to register the early console.

So there's nothing there which changes the default system console.

The next place is of_alias_scan() in drivers/of/base.c.  This records
the device_node and options in of_stdout and of_stdout_options
respectively - it, again, does not change the default system console.

When a serial console is initialised, of_console_check() gets called by
serial core to check whether the DT node for it is "of_stdout", and if
it matches, it modifies the preferred system console.

This all looks good, and one might expect that it has the desired
effect, but this code is fatally flawed in design: the point at which
of_console_check() gets called is _way_ after consoles like the virtual
terminal console get initialised.  What this means is that, at the point
in time that the virtual terminal is initialised, as far as the console
system is concerned, the preferred console is still the virtual terminal.
It knows nothing about the desire for a different console.

Given the current console handling, it's not easy to solve without
overhauling the way consoles are chosen - the root problem is that the
Linux console system works via Linux device driver names and indexes,
and there's no easy way to translate a DT stdout-path property to a
Linux device driver name and index without the driver having been
initialised.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
