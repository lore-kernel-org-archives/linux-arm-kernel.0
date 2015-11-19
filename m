From: robh@kernel.org (Rob Herring)
Date: Thu, 19 Nov 2015 08:30:34 -0600
Subject: [PATCH v6 3/6] dt/bindings: add bindings for optee
In-Reply-To: <20151119091810.GA15974@ermac>
References: <1446106888-8983-1-git-send-email-jens.wiklander@linaro.org>
 <1446106888-8983-4-git-send-email-jens.wiklander@linaro.org>
 <20151116170109.GA20076@rob-hp-laptop> <20151119091810.GA15974@ermac>
Message-ID: <CAL_JsqLCW6Wekccwqc4U8qFO9thuNQ4+EO6-AoasQtH+Z6CdrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 3:18 AM, Jens Wiklander
<jens.wiklander@linaro.org> wrote:
> On Mon, Nov 16, 2015 at 11:01:10AM -0600, Rob Herring wrote:
>> On Thu, Oct 29, 2015 at 09:21:25AM +0100, Jens Wiklander wrote:
>> > Introduces optee prefix and adds bindings for ARM TrustZone based OP-TEE
>> > implementation.
>> >
>> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>> > ---
>> >  .../bindings/arm/firmware/optee,optee-tz.txt       | 29 ++++++++++++++++++++++
>> >  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>> >  2 files changed, 30 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/arm/firmware/optee,optee-tz.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/arm/firmware/optee,optee-tz.txt b/Documentation/devicetree/bindings/arm/firmware/optee,optee-tz.txt
>> > new file mode 100644
>> > index 0000000..0a8ed0d
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/arm/firmware/optee,optee-tz.txt
>> > @@ -0,0 +1,29 @@
>> > +OP-TEE Device Tree Bindings
>> > +
>> > +OP-TEE is a piece of software using hardware features to provide a Trusted
>> > +Execution Environment. The security can be provided with ARM TrustZone, but
>> > +also by virtualization or a separate chip. As there's no single OP-TEE
>> > +vendor we're using "optee" as the first part of compatible property,
>> > +indicating the OP-TEE protocol is used when communicating with the secure
>> > +world.

[...]

>> > +Example:
>> > +   optee {
>>
>> This should go under a /firmware node similar to
>> Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt.
>
> I tried that and discovered that a
> compatible = "simple-bus";
> is needed for the firmware node for optee to get probed. Is it OK to write
> the example as:
>
> firmware {
>         compatible = "simple-bus";
>
>         optee {

That would needlessly create devices for any other child nodes and it
is not a bus. Just find the node and call of_platform_device_create
for that node in an initcall.

Rob
