From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 13 May 2014 15:21:52 +0200
Subject: [PATCH RFC 0/5] Hybrid approach for DT schema checking
In-Reply-To: <1392919611-10746-1-git-send-email-t.figa@samsung.com>
References: <1392919611-10746-1-git-send-email-t.figa@samsung.com>
Message-ID: <53721C70.2030106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just wanted to add that you can also find the code in my dtc tree on
kernel.org:

git://git.kernel.org/pub/scm/linux/kernel/git/tfiga/dtc.git

or if you prefer web interface to quickly look through the changes:

https://git.kernel.org/cgit/linux/kernel/git/tfiga/dtc.git/

Best regards,
Tomasz

On 20.02.2014 19:06, Tomasz Figa wrote:
> This series adds a proof of concept framework to implement schema checker
> using a combined C and DTSS based approach. Several example bindings are
> also implemented using C and DTSS[1].
> 
> Complex and generic bindings can be implemented directly in C and then
> instantiated from simple device-specific bindings using DTS-like DTSS
> language.
> 
> A quick description of C part:
> 
> A new check is registered in dtc checks framework to perform schema checking
> of each node. Checking is done by searching specified schema set for matching
> schemas (by compatible, device_type or absolute path) and applying matched
> schemas to the node.
> 
> Schemas for complex generic bindings (such as interrupts, gpios, clocks, i2c,
> mmio-bus, etc.) can be implemented directly in C and instantiated from DTSS
> schemas of particular devices. An example C schema may look like:
> 
> static void generic_checkfn_xxx_yyy(const struct generic_schema *schema,
> 				    struct node *root, struct node *node,
> 				    struct node *params, bool required)
> {
> 	/*
> 	 * Get necessary schema arguments from DTSS schema by looking
> 	 * at properties of @params node.
> 	 * 
> 	 * Check whether @node node matches the schema.
> 	 *
> 	 * The @required argument may be used to check whether some error
> 	 * conditions should be ignored (e.g. unspecified interrupt).
> 	 */
> }
> GENERIC_SCHEMA("xxx-yyy", xxx_yyy);
> 
> A quick description of DTSS part:
> 
> * DTSS is a DTS-like language for specification of simple bindings, e.g.
>   bindings of particular devices. The basic syntax is very similar to DTS,
>   with main elements being nodes and properties. At root level a series of
>   nodes should be specified representing particular bindings:
> 
> 	/dtss-v1/;
> 
> 	binding1 {
> 		/* Definition of binding 1 */
> 	};
> 
> 	binding2 {
> 		/* Definition of binding 2 */
> 	};
> 
> * Matching key for each binding can be specified using /match/ keyword:
> 
> 	root-node {
> 		/match/ path = "/";
> 	};
> 
> 	wlf,wm8903 {
> 		/match/ compatible = "wlf,wm8903";
> 	};
> 
> 	pci-bus {
> 		/match/ device_type = "memory";
> 	};
> 
>   Currently supported matches: path, compatible, device_type.
> 
> * Bindings can be specified either by listing properties they require
>   (or can use) directly or by instantiating generic C-based bindings.
> 
> 	binding {
> 		required-property;
> 
> 		/optional/ optional-property;
> 
> 		/require/ required-generic-schema;
> 
> 		/use/ optional-generic-schema {
> 			schema-argument = <1>;
> 		};
> 	};
> 
>   Generic schemas are implemented in C, as described above, and can use
>   arguments specified in DTSS as properties. /require/ calls the schema with
>   required=true, while /use/ with required=false.
> 
> This is based on Stephen Warren's C based DT schema checker proof of
> concept patch adding C-based validation[2].
> 
> TODO:
>  - specification of subnodes directly from DTSS,
>  - specification of simple property values from DTSS (cells, strings,
>    phandles),
>  - reporting of unrecognized properties,
>  - probably many more...
> 
> [1] Device Tree Schema Source
> [2] http://thread.gmane.org/gmane.linux.ports.arm.kernel/275896
> 
> Tomasz Figa (5):
>   dtc: Add helpers for various message levels
>   dtc: livetree: Add more tree parsing helpers
>   Another try of DT schema checker using hybrid C and DTSS based
>     approach
>   Add sample C-based generic bindings
>   Add sample DTS and DTSS schema
> 
>  Makefile                                  |   2 +-
>  Makefile.dtc                              |  10 +-
>  checks.c                                  |  15 +
>  dtc.c                                     |  17 +-
>  dtc.h                                     |  57 ++++
>  dtss-lexer.l                              | 291 +++++++++++++++++++
>  dtss-parser.y                             | 341 ++++++++++++++++++++++
>  livetree.c                                | 230 +++++++++++++++
>  sample.dts                                |  70 +++++
>  schema.dtss                               |  86 ++++++
>  schemas/clock/clock.c                     |  77 +++++
>  schemas/gpio/gpio.c                       |  93 ++++++
>  schemas/i2c/i2c.c                         |  42 +++
>  schemas/interrupt-controller/interrupts.c | 452 ++++++++++++++++++++++++++++++
>  schemas/mmio-bus.c                        |  97 +++++++
>  schemas/schema.c                          | 311 ++++++++++++++++++++
>  schemas/schema.h                          |  89 ++++++
>  srcpos.h                                  |   2 +
>  treesource.c                              |  22 ++
>  19 files changed, 2300 insertions(+), 4 deletions(-)
>  create mode 100644 dtss-lexer.l
>  create mode 100644 dtss-parser.y
>  create mode 100644 sample.dts
>  create mode 100644 schema.dtss
>  create mode 100644 schemas/clock/clock.c
>  create mode 100644 schemas/gpio/gpio.c
>  create mode 100644 schemas/i2c/i2c.c
>  create mode 100644 schemas/interrupt-controller/interrupts.c
>  create mode 100644 schemas/mmio-bus.c
>  create mode 100644 schemas/schema.c
>  create mode 100644 schemas/schema.h
> 
