From: maxi.jourdan@wanadoo.fr (Maxime Jourdan)
Date: Tue, 14 Aug 2018 04:42:25 +0200
Subject: [PATCH v2 2/4] dt-bindings: soc: amlogic: add meson-canvas
 documentation
In-Reply-To: <20180813190721.GA27621@rob-hp-laptop>
References: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
 <20180807220011.24436-3-maxi.jourdan@wanadoo.fr>
 <20180813190721.GA27621@rob-hp-laptop>
Message-ID: <CAHStOZ5i_SzamBsWk-b+X2n_gxdNJUPCHL1U0M-d6rdJgXkzrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-08-13 21:07 GMT+02:00 Rob Herring <robh@kernel.org>:
> On Wed, Aug 08, 2018 at 12:00:09AM +0200, Maxime Jourdan wrote:
>> DT bindings doc for amlogic,meson-canvas
>>
>> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
>> ---
>>  .../soc/amlogic/amlogic,meson-canvas.txt      | 36 +++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
>> new file mode 100644
>> index 000000000000..5f0351717bee
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
>> @@ -0,0 +1,36 @@
>> +Amlogic Canvas
>> +================================
>> +
>> +A canvas is a collection of metadata that describes a pixel buffer.
>> +Those metadata include: width, height, phyaddr, wrapping, block mode
>> +and endianness.
>> +
>> +Many IPs within Amlogic SoCs rely on canvas indexes to read/write pixel data
>> +rather than use the phy addresses directly. For instance, this is the case for
>> +the video decoders and the display.
>> +
>> +Amlogic SoCs have 256 canvas.
>> +
>> +Device Tree Bindings:
>> +---------------------
>> +
>> +Canvas Provider
>> +--------------------------
>> +
>> +Required properties:
>> +- compatible: "amlogic,canvas"
>> +
>> +Parent node should have the following properties :
>> +- compatible: "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd"
>
> Is this documented somewhere? One child function is not a reason for an
> MFD and child nodes. And child nodes like this with no resources are
> unnecessary.
>

Hi Rob, this was done to follow the same path as other buses on the
platform that have sysctrls in order to provide regmaps to the
devices.

I can see how it's not really necessary here though, would it be okay
with you if I turned "canvas" into a simple bus subnode, using __iomem
in the device ?

>> +- reg: base address and size of the DMC system control register space.
>> +
>> +Example:
>> +
>> +sysctrl_DMC: system-controller at 0 {
>> +     compatible = "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd";
>> +     reg = <0x0 0x0 0x0 0x1000>;
>> +
>> +     canvas: canvas-provider at 0 {
>> +             compatible = "amlogic,canvas";
>> +     };
>> +};
>> --
>> 2.18.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
