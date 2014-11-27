From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Nov 2014 14:10:32 +0100
Subject: [PATCH 4/7] pinctrl: zynq: Document DT binding
In-Reply-To: <682b075ae056422683f93be4ea892011@BL2FFO11FD024.protection.gbl>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-5-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdazagbSZdMvHTggQuAFm9uObn2ARoCwcyM-sspuLTXqkQ@mail.gmail.com>
 <682b075ae056422683f93be4ea892011@BL2FFO11FD024.protection.gbl>
Message-ID: <CACRpkdZfWKonvOfGEzz6bPxjzoBRb72Ydkov9X9YaMLbKiMn-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 7:53 PM, S?ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> On Tue, 2014-11-11 at 04:00PM +0100, Linus Walleij wrote:

>> I don't really like that you mix multiplexing and config in the
>> same node. I would prefer if the generic bindings say we have
>> muxing nodes and config nodes, and those are disparate.
>>
>> Can't you just split this:
>>
>> common-mux {
>>     groups = "uart1_10_grp";
>>     function = "uart1";
>> };
>>
>> common-config {
>>     groups = "uart1_10_grp";
>>     slew-rate = <0>;
>>     io-standard = <1>;
>> };
>>
>> That way we can identify nodes as mux nodes (have "function")
>> or config nodes (have "groups" or "pins" but not "function") which
>> I think makes things easier to read.
>
> I think such separation is not required by the bindings currently and
> the parser assumes everything can be present in any node.

The bindings say:

== Generic pin multiplexing node content ==

pin multiplexing nodes:

function                - the mux function to select
groups                  - the list of groups to select with this function

Example:

state_0_node_a {
        function = "uart0";
        groups = "u0rxtx", "u0rtscts";
};
state_1_node_a {
        function = "spi0";
        groups = "spi0pins";
};


== Generic pin configuration node content ==

(...)
Supported generic properties are:

pins                    - the list of pins that properties in the node
                          apply to (either this or "group" has to be
                          specified)
group                   - the group to apply the properties to, if the driver
                          supports configuration of whole groups rather than
                          individual pins (either this or "pins" has to be
                          specified)

It is not explicit that they have to be separate nodes but if needed
we can state that more clearly.

> Can we add that requirement to the generic bindings without breaking
> current users? I think it would make the implementation a little easier.

I think so.

Yours,
Linus Walleij
