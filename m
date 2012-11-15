From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 Nov 2012 18:20:05 +0100
Subject: [PATCH] Device Tree binding for the 'mv_xor' XOR engine DMA driver
Message-ID: <1353000034-30567-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set adds a Device Tree binding for the Marvell XOR engine
driver, which allows to support these XOR engines in the Armada 370
and Armada XP SoCs.

As one can immediatly see, this Device Tree binding patch set is not
as simple as most Device Tree bindings additions. This is due to the
fact that the mv_xor driver has a fairly odd organization. Instead of
registering a single platform_driver having platform_device structures
being instantiated together with platform_data structures describing
their specificities, this driver was organized around *two*
platform_driver:

 * One platform_driver named 'mv_xor_shared', for which one device was
   registered for each XOR engine (usually two in each Marvell SoC)

 * One platform_driver named 'mv_xor', for which one device was
   registered for each XOR channel (usually two per XOR engine). When
   those devices were registered, they contained a reference to the
   corresponding 'mv_xor_shared' device.

This unusual organization is:

 * useless, because the channels description can just as well be passed
   through platform_data of the 'mv_xor_shared' driver.

 * annoying, as it prevents the addition of a simple Device Tree
   binding for the driver.

Therefore, before adding the Device Tree binding, we cleanup and
reorganize the driver so that it registers a single platform_driver.

The patch set is organized as follows:

 * Patch 1 and 2 are basic cleanups, not really important.

 * Patch 3 to 8 are needed to remove the 'mv_xor'
   platform_driver. Instead of doing that as one big patch, we do it
   progressively, in small chunks, where each chunk builds and runs
   properly on the hardware.

   - Patch 3 moves the channel registration/cleanup logic into
     separate utility functions, so that they can be used for both the
     old-style probing (through the 'mv_xor' sub-driver) and the
     new-style probing (through platform_data passed to the main
     'mv_xor_shared' driver).

   - Patch 4 adds the possibility of registering channels through
     platform_data passed to the 'mv_xor_shared' main driver.

   - Patch 5 and Patch 6 respectively convert the XOR0 and XOR1 engine
     registrations to the new style probing.

   - Patch 7 removes some code that became useless in the process.

   - Patch 8 removes the sub-driver 'mv_xor'.

 * Patch 8 to 26 are further cleanups to the driver, mainly fixing the
   following problems:

   - All reference to the notion of 'shared' driver are removed.

   - The mv_xor driver registers one DMA engine and one DMA channel
     per XOR channel, because the different XOR channels in a given
     XOR engine have different capabilities. However, the mv_xor
     driver was internally keeping two structures having a 1:1
     mapping: mv_xor_device and mv_xor_chan, which was useless. We
     progressively convert the driver so that mv_xor_device represents
     one XOR engine, and mv_xor_chan represents one XOR channel.

   - Removing useless properties from the platform_data in order to
     simplify the Device Tree binding.

 * Patch 27 is a bug fix for the removal path, but it isn't very
   important as the driver cannot be compiled as a module.

 * Patch 28 adds the Device Tree binding itself and its documentation.

 * Patch 29 adds the Device Tree data to register the XOR engines on
   Armada 370/XP SoCs. Not Device Tree data is needed at the board
   level since those devices are purely internal to the SoC.

The resulting patch set is fully bisectable, and has been tested with
the built-in XOR engine self-test of the driver on both a Kirkwood
platform and a Armada XP platform.

The code is also available in the 'mvebu-xor' branch in the following
Git repository:

  git at github.com:MISL-EBU-System-SW/mainline-public.git

Note that PATCH 29 requires the clk patches from Gr?gory Clement for
the Armada 370/XP SoCs, which have already been Ack'ed, but not merged
yet.

Best regards,

Thomas
