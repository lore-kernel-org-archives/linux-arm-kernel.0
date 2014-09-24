From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Wed, 24 Sep 2014 14:50:04 +0000
Subject: [PATCH V3 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <3563146.jh46O3eIbG@wuerfel>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
 <6499926.sQm3J8L764@wuerfel> <20140904091319.GA32228@leverpostej>
 <3563146.jh46O3eIbG@wuerfel>
Message-ID: <eece3d41d2f0408ab235f9915eed40a6@CY1PR0301MB0748.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So there is still an open issue that has not been closed related to
what device trees should have with respect to enable-method.  There 
are 2 proposals from Mark and Arnd--

1.  Put comment in /cpus node in dts (Mark)

     ...
        cpus {
                #address-cells = <2>;
                #size-cells = <0>;

                /*
                 * We expect the enable-method to be "psci", but this is dependent on
                 * the FW, which will fill this in.
                 */

                cpu at 0 {
                        device_type = "cpu";
                        compatible = "arm,cortex-a57";
                        reg = <0x0 0x0>;
                };
     ...


2.  Put explicit psci enable-method in cpu nodes, to make it clear that psci 
    is expected.  Plus include empty psci node with a comment. (Arnd)

     ...
       /*
        * We expect the enable-method to be "psci", but this is dependent on
        * the FW, which will fill this in.
        */
        psci {
        }
     ...
        cpus {
                #address-cells = <2>;
                #size-cells = <0>;

                cpu at 0 {
                        device_type = "cpu";
                        compatible = "arm,cortex-a57";
                        reg = <0x0 0x0>;
                        enable-method = "psci";
                };
     ...


I would prefer #1.  I think putting "hints" like the psci node and
the enable-method are weak at best.  I think the comment in #1 is
enough to make the preferred approach clear.  In the end firmware will 
override the nodes and properties if it wants or needs to.

Thanks,
Stuart
