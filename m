From: dianders@chromium.org (Doug Anderson)
Date: Mon, 2 Jul 2018 14:03:21 -0700
Subject: [PATCH v2 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
In-Reply-To: <20180702205146.GA129942@google.com>
References: <20180702181005.18247-1-mka@chromium.org>
 <CAD=FV=VSnKWqeRj-Kr9tkzeuqxm86Ex6E0uT6Qka=EqjurizNg@mail.gmail.com>
 <20180702205146.GA129942@google.com>
Message-ID: <CAD=FV=WmK_PtZqQLVwZ7NFN8qJngH4j-oarS8Jv48x79wR5cNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 2, 2018 at 1:51 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
>> > +                       compatible = "qcom,spmi-temp-alarm";
>> > +                       reg = <0x2400 0x100>;
>>
>> Why are there two numbers for the "reg"?  Should just be 0x2400.
>
> From /Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt:
>
> Required properties:
> ...
> - reg:             Specifies the SPMI address and length of the controller's
>                    registers.

Hrm, something isn't adding up here.

A) Do a "git grep" and you'll see that nobody else has the length.

$ git grep -C2 -- qcom,spmi-temp-alarm | grep reg

arch/arm/boot/dts/qcom-pm8841.dtsi-                     reg = <0x2400>;
arch/arm/boot/dts/qcom-pm8941.dtsi-                     reg = <0x2400>;
arch/arm/boot/dts/qcom-pma8084.dtsi-                    reg = <0x2400>;
arch/arm64/boot/dts/qcom/pm8916.dtsi-                   reg = <0x2400>;

---

B) The SPMI bus you're adding it to has "#size-cells = <0>;"  ...as do
all other SPMI busses:

$ git grep -C5 qcom,spmi-pmic | grep size-cells
arch/arm/boot/dts/qcom-pm8841.dtsi-             #size-cells = <0>;
arch/arm/boot/dts/qcom-pm8841.dtsi-             #size-cells = <0>;
arch/arm/boot/dts/qcom-pm8941.dtsi-             #size-cells = <0>;
arch/arm/boot/dts/qcom-pm8941.dtsi-             #size-cells = <0>;
arch/arm/boot/dts/qcom-pma8084.dtsi-            #size-cells = <0>;
arch/arm/boot/dts/qcom-pma8084.dtsi-            #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8004.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8004.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8005.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8005.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8916.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8916.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8994.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8994.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8998.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pm8998.dtsi-           #size-cells = <0>;
arch/arm64/boot/dts/qcom/pmi8994.dtsi-          #size-cells = <0>;
arch/arm64/boot/dts/qcom/pmi8994.dtsi-          #size-cells = <0>;

...I have no SPMI history, but my guess is that upstream dropped this
because all SPMI devices have 256-byte regions (see
qcom,spmi-pmic.txt)?


So probably the right thing is to fix the qcom,spmi-temp-alarm not to
have the size...

-Doug
