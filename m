From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 Feb 2014 19:15:05 +0000
Subject: [PATCH v5 00/23]
In-Reply-To: <20140202195400.073f4eb4@armhf>
References: <cover.1390986082.git.moinejf@free.fr>
 <20140202124358.GD26684@n2100.arm.linux.org.uk>
 <20140202190606.6fa193ce@armhf>
 <20140202182349.GJ26684@n2100.arm.linux.org.uk>
 <20140202195400.073f4eb4@armhf>
Message-ID: <20140202191505.GK26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 02, 2014 at 07:54:00PM +0100, Jean-Francois Moine wrote:
> I explained how to use the tda998x in a DT context in a message to Jyri
> Sarha:
> 
> http://lists.freedesktop.org/archives/dri-devel/2014-January/052936.html

Okay, so there's a bunch of changes required to the DRM slave support
which aren't in place yet.

In which case, it may be better to reorder the remaining patches such
that the DT changes are at the very end - which means we can still
benefit from the rest of the patches if the DT solution remains an
open question.

We do have another option now that my generic component support is in
mainline (merged during this window), which should result in a much
cleaner solution.  If we convert TDA998x to a component, armada DRM
to a component master (and same for other tda998x users) then we don't
need the drm_encoder_slave stuff - all that goes away since it's no
longer necessary.

We also solve this problem as well - because we're then not messing
around with working out if there's a DT node present: the TDA998x
device must pre-exist.  For non-DT setups, this can be done when
the I2C bus is created - devices on it would be created using the
standard mechanisms already present via the i2c_board_data array.
For DT setups, the devices are created by parsing the I2C bus node
in DT.

Both cases result in a component being registered upon invocation of
tda998x_probe(), and removal of the component when tda998x_remove()
is called.  The tda998x driver becomes a standard I2C driver.

This is something I've been intending to look at now that the component
stuff is in place - as I said previously when the questions around DT
and Armada DRM were first posed, we need to solve these issues in a
generic way first, rather than hacking around them.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
