From: dirk.behme@gmail.com (Dirk Behme)
Date: Thu, 04 Jul 2013 20:36:05 +0200
Subject: Appended DTB files for multi-machine kernels
In-Reply-To: <51D5A938.30607@gmail.com>
References: <51D5A938.30607@gmail.com>
Message-ID: <51D5C095.4070909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 04.07.2013 18:56, schrieb Daniel Mack:
> Hi,
>
> I'm facing a problem with a transition from legacy board-file driven ARM
> machines to DTB, and I'm under the impression that a solution for it
> could be of broader interest.
>
> In short, devices that have been deployed in quantities come in three
> hardware variants, which all boot with a unique machine-id. We ship
> kernel images that have board support for all three machine types, and
> do minor fixups to platform data of some drivers at runtime, depending
> on the board revision number (passed in via ATAGs).
>
> The built-in support for attaching a DTB to the zImage does not suffice
> here, because we have one image for all models, and also, we couldn't do
> a 'per-board-revision' selection that way either.
>
> Unless I missed some recent discussion, this case is not easy to handle.
> Yes, I know that these kind of things should be handled by a
> next-generation bootloader, but in our case, we want to avoid a loader
> update of already shipped hardware by all means.
>
> As a solution, I'm thinking of a small framework that could for example
> work as follows.
>
> a) A small mechanism allows storing multiple DTB binary files inside the
> kernel binary at compile time, and a simple function can extract them
> again by name at runtime (something like what the firmware framework
> does, but I don't know if that one can be used at such an early stage in
> the boot process).
>
> b) A DT_MACHINE_START-like macro takes both the machine ID and the name
> of a DTB file that is compiled in. When matched, generic functions would
> load the given file, populate the device tree and then conduct a generic
> DT boot for the specified platform.
>
> c) Allow users to open-code the DTB lookup depending on whatever kind of
> runtime information (be it the board_revision or anything else).
>
>
> Of course, everything has to be an opt-in that stubs itself out at zero
> costs if not needed.
>
>
> I'm open to opinion and sugesstions :)

Depending on how different the board support for all your three 
machine types is, there might be an (of course unimplemented) option

d) have only one DTB file which contains all the information for your 
three machine types and then have a mechanism which selects 
("activates") the entries valid for the board you boot based on some 
external information, e.g. the machine ID. I.e. you have one DTB file 
which contains alternative entries for the different boards. And which 
entry is used/activated is selected at (early) kernel runtime by the 
machine ID.

What I'm thinking about here is an extended version of the device tree 
overlays used (invented?) by the Beagle board community. They have a 
base device tree file and for their add on boards (capes) they load 
device tree overlay files based on an EEPROM ID read.

http://elinux.org/BeagleBone_and_the_3.8_Kernel#Cape_Manager_and_Device_Tree_Overlays

With this, they extend the device tree at runtime based on the 
attached extension boards.

Going one step further, having the alternative plugin/overlay 
definitions already in the initial DTB file and being able to 
select/activate single plugin/overlay definitions already in the early 
boot stage should give a general mechanism to support several, similar 
boards with slightly different configurations with one DTB.

Best regards

Dirk
